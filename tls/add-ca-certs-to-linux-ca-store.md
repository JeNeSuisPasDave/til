# Add CA certificates to Linux system CA certificate store

_Tested on Alpine 3.4 with OpenSSL 2.0.5._

You can add one or more root (or intermediate) CA certificates to the Linux system trusted certificate store by:

0. Make sure `openssl` is installed.
1. Convert the certs from PEM files to CRT files using: `openssl x509 -outform pem -in rootCAcert.pem -out rootCAcert.crt`
2. Copy the cert to `/usr/local/share/ca-certificates/`
3. Update the system CA certificate store using the command `update-ca-certificates`

_Note 1:_ You can put multiple certificates in `/usr/local/share/ca-certificates/` before running the `update-ca-certificates` command.

_Note 2:_ You will need to run `sudo update-ca-certificates` if not running as root.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
