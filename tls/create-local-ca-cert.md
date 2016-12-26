# Create a CA cert on local machine

_Tested with OpenSSL 1.0.2j on OS X El Capitan (10.11.6)._

I want to create a CA cert that I can use to authenticate server certificates that I use locally and in non-public scenarios (e.g. within a private network).

I've got `openssl` installed on my OS X 10.11 (El Capitan) system. I used [Mac Ports][macports] to install it.

[macports]: https://www.macports.org/

## Create the CA directory structure

```bash
mkdir ~/.CA
chmod og-rx ~/.CA
```

## Rolling CA certs

You want your CA certs to last a long time, but not too long. Not more tha a few years. You likely don't have the budget or infrastructure to maintain a super secure enclave for your CA private keys, so it doesn't make sense to try to keep CA private keys viable for 30 years (like some commercial CAs do).

I think a good compromise is to give the certs a TTL of three years, and to generate a new CA cert every year (from a new private key). That way you can roll the CA certs, retiring one every 3 years. And the server keys signed by the CA cert should always be signed by the most recent CA cert, and those server certs should have a TTL of less than 2 years.

This policy keeps your certs fresh. It also pushes you to build in some automation for certification distribution and maintenance. You'll need automation to update expiring certs and to roll the CA certs in your trusted store. And that's a good thing.

## create the passphrase file

You'll need a passphrase for the private key of the CA cert. The way I like to do it is to put it in a file (the passphrase will be the first line of the file) in the `~/.CA` directory.

I like to name the file with the year the CA cert will be issued, e.g. `.ca_2016_passphrase`. Stick in a nice, long, hard to guess passphrase on line 1 and make sure there is a line 2 that is empty. Then protect access to the file with something like `chmod 400 .ca_2016_passphrase`.

## create an openssl.cnf file

`openssl` uses a configuration file. On my system that file is `/opt/local/etc/openssl/openssl.cfg`. You'll need to make a copy of that file and then tweak it a bit. Put the copy in the `~/.CA` directory and name it something like `ca_2016_openssl.cnf`.

Edit that file and find each place where the `dir` macro is set. Change that from `./demoCA` to `./root_ca_YYYY` where `YYYY` is the year the CA cert will be issued, e.g. `./root_ca_2016`. Nothing else needs changing (though you could make more changes and skip some command line arguments).

## The ca_make.sh script

Create a shell script called `ca_make.sh`, give it execution permission (`chmod u+x ca_make.sh`), and put this Bash source code in it:

```bash
#! /bin/bash
#
SSLEAY_CONFIG="-config ./ca_2016_openssl.cnf"
ROOTCA_YEAR="2016"

# Identify Root CA directories
#
ROOTCA_DIR="root_ca_${ROOTCA_YEAR}"
ROOTCA_CERTS_DIR="${ROOTCA_DIR}/certs"
ROOTCA_CRL_DIR="${ROOTCA_DIR}/crl"
ROOTCA_NEWCERTS_DIR="${ROOTCA_DIR}/newcerts"
ROOTCA_PRIVATE_DIR="${ROOTCA_DIR}/private"

# Create the Root CA
#
mkdir "${ROOTCA_DIR}"
mkdir "${ROOTCA_CERTS_DIR}"
mkdir "${ROOTCA_CRL_DIR}"
mkdir "${ROOTCA_NEWCERTS_DIR}"
mkdir "${ROOTCA_PRIVATE_DIR}"
chmod 700 "${ROOTCA_PRIVATE_DIR}"
touch "${ROOTCA_DIR}/index.txt"
ROOTCA_SUBJ="/C=US/ST=TX/L=Houston/O=Freshthought\ Company/OU=HQ"
ROOTCA_SUBJ="${ROOTCA_SUBJ}/CN=Freshthought\ CA\ ${ROOTCA_YEAR}"
ROOTCA_PASS="file:.ca_${ROOTCA_YEAR}_passphrase"
openssl req $SSLEAY_CONFIG -new \
  -keyout "${ROOTCA_PRIVATE_DIR}/rootCAkey.pem" \
  -out "${ROOTCA_DIR}/rootCAreq.pem" \
  -subj "${ROOTCA_SUBJ}" \
  -passout "${ROOTCA_PASS}"
chmod 600 "${ROOTCA_PRIVATE_DIR}/rootCAkey.pem"
openssl ca $SSLEAY_CONFIG -create_serial \
  -out "${ROOTCA_DIR}/rootCAcert.pem" \
  -outdir "${ROOTCA_DIR}" \
  -days 1095 -batch \
  -keyfile "${ROOTCA_PRIVATE_DIR}/rootCAkey.pem" \
  -passin "$ROOTCA_PASS" \
  -selfsign -extensions v3_ca \
  -infiles "${ROOTCA_DIR}/rootCAreq.pem"
```

You'll want to change these variables:

* SSLEAY_CONFIG
* ROOTCA_YEAR
* ROOTCA_SUBJ

## Create the CA private key and cert

`cd ~/.CA` and run the `ca_make.sh` script. You'll see output something like this:

```nohightlight
Generating a 2048 bit RSA private key
..............................................+++
...........+++
writing new private key to 'root_ca_2016/private/rootCAkey.pem'
-----
Using configuration from ./ca_2016_openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number:
            8b:77:f6:51:fa:6f:a3:62
        Validity
            Not Before: Dec 26 00:43:52 2016 GMT
            Not After : Dec 26 00:43:52 2019 GMT
        Subject:
            countryName               = US
            stateOrProvinceName       = TX
            organizationName          = Freshthought Company
            organizationalUnitName    = HQ
            commonName                = Freshthought CA 2016
        X509v3 extensions:
            X509v3 Subject Key Identifier:
                2D:FA:D2:7E:8A:18:C8:BA:93:EA:B0:7E:42:44:16:59:41:F6:54:D2
            X509v3 Authority Key Identifier:
                keyid:2D:FA:D2:7E:8A:18:C8:BA:93:EA:B0:7E:42:44:16:59:41:F6:54:D2

            X509v3 Basic Constraints:
                CA:TRUE
Certificate is to be certified until Dec 26 00:43:52 2019 GMT (1095 days)

Write out database with 1 new entries
Data Base Updated
```

The important files resulting from this are:

* Private key: `~/.CA/root_ca_2016/private/rootCAkey.pem`
* CA Certificate: `~/.CA/root_ca_2016/rootCAcert.pem`

The certificate looks like (via `openssl x509 -text -in ~/.CA/root_ca_2016/rootCAcert.pem`):

```nohighlight
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            8b:77:f6:51:fa:6f:a3:62
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=TX, O=Freshthought Company, OU=HQ, CN=Freshthought CA 2016
        Validity
            Not Before: Dec 26 00:43:52 2016 GMT
            Not After : Dec 26 00:43:52 2019 GMT
        Subject: C=US, ST=TX, O=Freshthought Company, OU=HQ, CN=Freshthought CA 2016
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d8:00:26:f5:ce:c2:0a:9f:43:ae:d2:20:ea:e8:
                    b9:ca:89:69:bc:33:bf:4c:5a:6a:ca:f6:a9:b1:96:
                    b1:75:5e:d3:f9:03:42:73:64:f9:82:fb:c7:3e:16:
                    e1:25:d5:ab:3a:6e:cf:a7:bb:f2:f8:d6:84:cc:b3:
                    d0:da:ad:42:4d:6e:92:14:b0:55:ea:31:fb:da:44:
                    4b:cb:8a:da:60:57:ce:a5:69:06:a4:58:90:3a:d8:
                    01:43:d0:1a:fa:b2:5c:fb:61:69:60:85:13:61:d2:
                    54:f8:c9:1e:6e:0a:17:19:db:25:8f:32:2c:ab:0f:
                    cb:c9:4f:f3:68:cf:c9:8f:fb:93:76:5a:0a:ea:54:
                    6f:64:f7:ba:6d:de:73:64:5d:e4:01:da:8c:ea:79:
                    ec:78:72:bf:ab:32:83:29:7d:36:df:ca:aa:32:b0:
                    4a:d2:f4:35:f9:8b:d4:ac:6b:8f:a6:7e:72:b9:36:
                    48:f2:ce:02:d2:84:5d:fa:e8:1c:19:61:a8:d8:96:
                    8f:9e:27:a3:f1:a0:6a:da:26:af:40:54:30:ef:bb:
                    97:a7:bd:1c:eb:7e:93:42:c0:09:76:67:7d:7c:f7:
                    a8:b4:f6:2f:84:2e:7d:a5:49:f3:05:d9:8c:50:37:
                    ea:53:a1:45:b1:78:2a:82:d7:7f:63:f2:90:5a:e6:
                    52:33
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier:
                2D:FA:D2:7E:8A:18:C8:BA:93:EA:B0:7E:42:44:16:59:41:F6:54:D2
            X509v3 Authority Key Identifier:
                keyid:2D:FA:D2:7E:8A:18:C8:BA:93:EA:B0:7E:42:44:16:59:41:F6:54:D2

            X509v3 Basic Constraints:
                CA:TRUE
    Signature Algorithm: sha256WithRSAEncryption
         7e:2b:ba:25:2a:26:9d:a7:01:6c:09:72:f5:2b:a7:55:25:9e:
         66:77:95:22:05:da:f4:7f:50:87:cc:ca:9a:8d:aa:c4:9c:01:
         00:7a:84:08:c9:cf:26:6d:a3:30:c7:3e:e9:2e:e8:42:00:2a:
         4d:2f:72:51:a8:73:e1:4c:28:32:47:44:76:2a:28:78:ef:ee:
         29:04:fd:d6:f6:44:86:a4:c4:51:cf:72:72:b2:fb:d7:57:d3:
         45:b6:ed:f7:dc:50:df:cd:03:c8:b6:06:da:41:ff:c7:0f:d9:
         6b:a0:90:8e:68:d3:7d:01:ef:d2:62:ed:d2:0e:79:37:2d:f1:
         ad:90:24:c5:46:fc:56:12:2f:d6:7a:38:59:98:6f:71:b8:b5:
         86:8d:04:01:07:7f:6f:af:bb:04:f6:03:7d:c2:6c:4b:ef:56:
         ba:b8:3c:82:73:79:9f:13:0d:e5:df:3b:b1:12:1b:a0:36:2b:
         26:73:a8:6c:a4:88:80:2c:9e:1d:32:14:7b:8e:f2:92:34:99:
         d4:92:22:8e:38:83:f8:99:44:b0:84:cd:e3:e7:07:5c:17:9f:
         00:77:56:7f:b6:15:10:86:6b:7f:1c:45:8c:2d:6c:3b:57:15:
         8f:ce:37:f9:e3:f9:95:2f:2f:0b:b8:4b:b1:56:8e:2d:12:2a:
         da:d8:59:20
-----BEGIN CERTIFICATE-----
MIIDnTCCAoWgAwIBAgIJAIt39lH6b6NiMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNV
BAYTAlVTMQswCQYDVQQIDAJUWDEdMBsGA1UECgwURnJlc2h0aG91Z2h0IENvbXBh
bnkxCzAJBgNVBAsMAkhRMR0wGwYDVQQDDBRGcmVzaHRob3VnaHQgQ0EgMjAxNjAe
Fw0xNjEyMjYwMDQzNTJaFw0xOTEyMjYwMDQzNTJaMGUxCzAJBgNVBAYTAlVTMQsw
CQYDVQQIDAJUWDEdMBsGA1UECgwURnJlc2h0aG91Z2h0IENvbXBhbnkxCzAJBgNV
BAsMAkhRMR0wGwYDVQQDDBRGcmVzaHRob3VnaHQgQ0EgMjAxNjCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANgAJvXOwgqfQ67SIOroucqJabwzv0xaasr2
qbGWsXVe0/kDQnNk+YL7xz4W4SXVqzpuz6e78vjWhMyz0NqtQk1ukhSwVeox+9pE
S8uK2mBXzqVpBqRYkDrYAUPQGvqyXPthaWCFE2HSVPjJHm4KFxnbJY8yLKsPy8lP
82jPyY/7k3ZaCupUb2T3um3ec2Rd5AHajOp57Hhyv6sygyl9Nt/KqjKwStL0NfmL
1Kxrj6Z+crk2SPLOAtKEXfroHBlhqNiWj54no/Ggatomr0BUMO+7l6e9HOt+k0LA
CXZnfXz3qLT2L4QufaVJ8wXZjFA36lOhRbF4KoLXf2PykFrmUjMCAwEAAaNQME4w
HQYDVR0OBBYEFC360n6KGMi6k+qwfkJEFllB9lTSMB8GA1UdIwQYMBaAFC360n6K
GMi6k+qwfkJEFllB9lTSMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEB
AH4ruiUqJp2nAWwJcvUrp1UlnmZ3lSIF2vR/UIfMypqNqsScAQB6hAjJzyZtozDH
Puku6EIAKk0vclGoc+FMKDJHRHYqKHjv7ikE/db2RIakxFHPcnKy+9dX00W27ffc
UN/NA8i2BtpB/8cP2WugkI5o030B79Ji7dIOeTct8a2QJMVG/FYSL9Z6OFmYb3G4
tYaNBAEHf2+vuwT2A33CbEvvVrq4PIJzeZ8TDeXfO7ESG6A2KyZzqGykiIAsnh0y
FHuO8pI0mdSSIo44g/iZRLCEzePnB1wXnwB3Vn+2FRCGa38cRYwtbDtXFY/ON/nj
+ZUvLwu4S7FWji0SKtrYWSA=
-----END CERTIFICATE-----
```

## Credits

Got much of this from [this Slashdot answer](http://superuser.com/questions/462295/openssl-ca-and-non-ca-certificate#464288).
