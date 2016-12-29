# HTTPie: Verify HTTPS connection with system CA bundle

_Tested with Python 3.5.2 on Alpine 3.4._

I'm using the Python package **[HTTPie][httpie]** to test a RESTful API. The pertinent versions are:

[httpie]: https://httpie.org/doc

* HTTPie: 0.9.9
* requests: 2.12.4

The API has an HTTPS endpoint, so I added the root CA cert that signed the endpoint's server certificate to the system's trusted CA certificate store. But version 2.* of **requests**, upon which **HTTPie** depends, does not look for or use the system CA certificate store, so the `http` command got an error like this:

```nohighlight
http: error: SSLError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:645) while doing GET request to URL: https://flask.example.dev/api/v1.0/posts/
```

Happily, on Linux systems (like Alpine), all the trusted CA certs are bundled into this file: `/etc/ssl/certs/ca-certificates.crt`. That means you can supply that file to HTTPie's `--verify` argument and then HTTPie will verify the server certificate.

The command looks something like this:

```bash
http --json --verify=/etc/ssl/certs/ca-certificates.crt --auth : GET https://flask.example.dev/api/v1.0/posts/
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
