# Add a CA certificate to the OS X keychain

_Tested on OS X El Capitan (10.11.6)._

You've created a CA cert for use on your private network. Typically this certificate will be used to sign server certificates used to provide TLS handshaking for web servers and web API endpoints.

## Add CA certificate to System keychain

You need to add the certificate to your Mac's trusted store; specifically, you need to add it to the System keychain. You can do that with this command from an admin user account:

```bash
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" "~/some-dir/rootCAcert.pem"
```

Or you could launch the Keychain Access application, unlock the System keychain, and then import the CA certificate.

## Trusting the CA certificate

Because the certificate is self-signed, and because the private key is not in the keychain, the certificate you just imported is not trusted. To make Safari and OS X trust the cert, you'll need to use the Keychain Access application.

Launch Keychain Access. In the nav bar on the left, select the System keychain and select the Certificates category. You should see the certificate you just imported, probably with a red 'x' on it (indicating it is not trusted).

Unlock the System keychain. Then do a _Get Info_ on the certificate and expand the Trust setting. Then change "When using this certificate" to Always Trust. Close the dialog. Then, finally, lock the System keychain.

## Credit

Thanks to [this post](https://derflounder.wordpress.com/2011/03/13/adding-new-trusted-root-certificates-to-system-keychain/) for the pointer to the `security` CLI utility.

Do `man security` for more info and other useful commands related to the OS X keychain.
