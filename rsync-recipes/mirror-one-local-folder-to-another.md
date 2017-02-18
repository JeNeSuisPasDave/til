# Mirror one local folder to another

This will mirror one folder to another; all the contents of `helloworld-TLS/` will be identical to `helloworld/`&mdash;identical permissions, identical timestamps, and no extra files.

```bash
rsync -rptv --delete helloworld/ helloworld-TLS/
```

Alternatively, verbosely, this is equivalent:

```bash
rsync --recursive --perms --times --verbose --delete \
  helloworld/ helloworld-TLS/
```

If you want to preserve group and owner, as well as link files, do this:

```bash
rsync --archive --delete helloworld/ helloworld-TLS/
```

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
