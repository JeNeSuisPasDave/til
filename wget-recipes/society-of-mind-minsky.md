# Minsky's Society of Mind

Marvin Minsky's classic work, _Society of Mind_, has been released with a Creative Commons license in a [web browsable form][soc].

[soc]: http://aurellem.org/society-of-mind/index.html

You can make your own local copy with this `wget` recipe:

```bash
#! /bin/bash
#
wget -o wget.log --no-verbose --tries=2 --wait=1 --no-host-directories \
  --recursive --timestamping --level=inf \
  http://aurellem.org/society-of-mind/index.html
```

Run that script from the command line within a current directory called "`Society of Mind`" or something similar.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
