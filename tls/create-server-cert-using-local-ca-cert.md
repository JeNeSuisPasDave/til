# Create server certificate (using local CA)

_Tested with OpenSSL 1.0.2j on OS X El Capitan (10.11.6)._

Suppose you've got a variety of private servers and services that you want to make available via HTTPS endpoints, endpoints that are not accessible on the public Internet. HTTPS endpoints require a unique certificate for each endpoint host name, certificates that need to be trusted by a large number of clients. It is impractical to keep each client up to date with a trusted store of the complete and ever changing set of server certificates.

The solution is to use a small set of CA certificates that is distributed to each client's trusted certificate store, and then issue server certificates that have been signed by one of those CA certificates. Then server certificates can be created at will without the need to update every potential client that might encounter those server certificates.

## establishing the local CA certificate

The rest of this post assumes a local CA certificate and certificate database generates as described in [Create a CA cert on local machine](./create-local-cert.md). This solution depends that some of the files and directories created in the process of generating the CA cert as per that TIL.

## Add a server certificate extension section to OpenSSL config file

We want to make sure certain X509 extended attributes are set. To do that, update the OpenSSL config file (e.g. `~/.CA/ca_2016_openssl.cnf`) with this section:

```nohighlight
[ v3_usr ]
# Extensions for a typical server certificate

basicConstraints = critical, CA:false
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = critical, serverAuth, clientAuth
```

I typically put that near the `[ v3_ca ]` section.

## The cert_make.sh script

Generating the server certificate is similar to generating a CA cert. We create a private key and a CSR, and then we generate a certificate that contains the public key corresponding to the private key. But we don't add a challenge passphrase to encrypt the private key (because we don't want web servers and other services to have to supply the passphrase when they start or when they use the private key in the TLS handshaking). And we use the same OpenSSL configuration file as we used to create the CA. And we sign the certificate using the private key associated with the CA certificate.

This script does all that:

```bash
#! /bin/bash
#

# Acquire arguments
#
if [ -z "$1" ]; then
  echo "Please supply the FQDN"
  echo "No action taken."
  exit 2
fi
FQDN_=$1

# Initialization
#
SSLEAY_CONFIG="-config ./ca_2016_openssl.cnf"
ROOTCA_YEAR="2016"
CERT_SUBJ="/C=US/ST=TX/L=Houston/O=Testing\ Purposes/OU=HQ"
CERT_SUBJ="${CERT_SUBJ}/CN=${FQDN_}/emailAddress=none@none.org"

# Identify Root CA directories
#
ROOTCA_DIR="root_ca_${ROOTCA_YEAR}"
ROOTCA_CERTS_DIR="${ROOTCA_DIR}/certs"
ROOTCA_CRL_DIR="${ROOTCA_DIR}/crl"
ROOTCA_NEWCERTS_DIR="${ROOTCA_DIR}/newcerts"
ROOTCA_PRIVATE_DIR="${ROOTCA_DIR}/private"
ROOTCA_PASS="file:.ca_${ROOTCA_YEAR}_passphrase"

# Identify Cert directories
#
CERT_DIR="certs/${FQDN_}"
CERT_PRIVATE_DIR="${CERT_DIR}/private"

# Create the cert
#
mkdir "${CERT_DIR}"
mkdir "${CERT_PRIVATE_DIR}"
chmod 700 "${CERT_PRIVATE_DIR}"

openssl req $SSLEAY_CONFIG -new \
  -nodes -keyout "${CERT_PRIVATE_DIR}/certkey.pem" \
  -out "${CERT_DIR}/certreq.pem" \
  -days 90 \
  -subj "${CERT_SUBJ}"
chmod 600 "${CERT_PRIVATE_DIR}/certkey.pem"

openssl ca $SSLEAY_CONFIG \
  -cert "${ROOTCA_DIR}/rootCAcert.pem" \
  -keyfile "${ROOTCA_PRIVATE_DIR}/rootCAkey.pem" \
  -passin "$ROOTCA_PASS" \
  -policy policy_anything \
  -out "${CERT_DIR}/cert.pem" \
  -extensions v3_usr \
  -infiles "${CERT_DIR}/certreq.pem"

# Validate the cert
#
openssl verify -CAfile "${ROOTCA_DIR}/rootCAcert.pem" "${CERT_DIR}/cert.pem"
```

You'll want to change these variables:

* SSLEAY_CONFIG
* ROOTCA_YEAR
* ROOTCA_SUBJ

## Create the server private key and cert

`cd ~/.CA` and run the `cert_make.sh` script. Give it one argument that is the fully qualified domain name of the service host, e.g., "`test.example.dev`". You'll see output something like this (from the command `./cert_make.sh test.example.dev`):

```nohighlight
Generating a 2048 bit RSA private key
.+++
.....................+++
writing new private key to 'certs/test.example.dev/private/certkey.pem'
-----
Using configuration from ./ca_2016_openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number:
            fc:59:6f:1e:0f:65:e6:43
        Validity
            Not Before: Dec 26 23:23:40 2016 GMT
            Not After : Dec 26 23:23:40 2017 GMT
        Subject:
            countryName               = US
            stateOrProvinceName       = TX
            localityName              = Houston
            organizationName          = Testing Purposes
            organizationalUnitName    = HQ
            commonName                = test.example.dev
            emailAddress              = none@none.org
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: critical
                TLS Web Server Authentication, TLS Web Client Authentication
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                FB:9D:7C:DC:1B:7A:18:63:67:00:84:43:A7:0B:3E:DF:8D:5C:67:3B
            X509v3 Authority Key Identifier:
                keyid:59:05:10:61:58:22:D2:86:A5:E2:F1:99:57:5A:36:60:3C:58:9D:EA

Certificate is to be certified until Dec 26 23:23:40 2017 GMT (365 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
certs/test.example.dev/cert.pem: OK
```

_(Note that you will have to respond to a couple interactive prompts.)_

The important files resulting from this are:

* Private key: `~/.CA/certs/test-example-dev/private/certkey.pem`
* Server certificate: `~/.CA/certs/test-example-dev/cert.pem`

## The CA certificate database

The `openssl ca` command maintains a record of the server certificates. When you generate a new server certificate, the CA "database" updates the sequence number, stores a copy of the cert, and adds a line to an `index.txt` file (which is just a list of each cert and it's subject information).

If you create a certificate and don't like how it came out, then you'll need to manually remove that cert from the "database" before generating another with the same subject information. It's pretty easy to do ...

1. Look in the `./index.txt` file and note the sequence number of the cert (this is the 3rd field)
2. Remove the certificate file from the `./newcerts` folder that corresponds to that sequence number.
3. Remove that line from the `./index.txt` file.

That's it.

Note that if you've already issued the certificate and want to issue another with the same subject then you'll need to invalidate the certificate (which involves adding it to he CRL). Doing that is a topic for another day and another TIL.

## Using the cert

When you use the certificate with a web server or other HTTPS endpoint then you'll need to "chain" together the CA cert and the server cert, and you'll need to provide the endpoint with the private key.

You chain the cert by appending PEM files. **The order is important.** Chain from outermost to innermost. Each item in the "chain" is to be verified by the subsequent item in the "chain". So you'd do something like this:

```bash
cat ~/.CA/certs/test.example.dev/cert.pem \
  ~/.CA/root_ca_2016/rootCAcert.pem > myserver.pem
```

## Credits

For the general example of creating a CA cert and using it to create server certs, thanks goes to [this superuser.com post][opensslca].

For the tip about the sequencing of PEM files when building a chain PEM file, thanks goes to [this Stack Overflow post][chaining].

[opensslca]: http://superuser.com/a/464288/676289
[chaining]: http://stackoverflow.com/a/17420863/1392864
