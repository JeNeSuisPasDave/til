# Ignore modification time when pushing changes

Suppose you are copying from a source directory that is frequently regenerated, but you only want to pick up changed files and you don't want to change modification times of files in the target directory unless the file content has changed.

An example would be regenerating a static website locally and pushing just the changes up to the web server. If you relied on comparing timestamps between source and target then you'd end up sending all the files every time, whether the content changed or not. Clearly undesirable.

The solution is to tell rsync to ignore the modification time and use a checksum of the file contents. Like this:

```bash
rsync --verbose --checksum --recursive --delete \
  --omit-dir-times \
  generated-blog/ remote-site/blog/
```

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
