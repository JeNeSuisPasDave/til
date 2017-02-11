# Works of George Orwell

There is a [site][site] that has all the works of George Orwell available online. Formatting is OK, but not great. Some typos. But it is all there.

[site]: http://george-orwell.org/l_orwell-essay.html

You can retrieve a local copy using `wget` in this way:

```bash
#! /bin/bash
#
# Retrieve George Orwell's essays from -
#   http://george-orwell.org/l_orwell-essay.html
#
wget -o wget.log --no-verbose \
  --recursive \
  --timestamping \
  --level=inf \
  --convert-links \
  --domains=george-orwell.org,www.george-orwell.org \
  http://www.george-orwell.org/l_orwell-essay.html

```

Some interesting things about this command:

* the `--domains` arg is necessary because the main site is sans `www.` but all the internal links reference the domain _with_ the `www.` prefix. If you don't supply that `--domains` argument then you'll get very few pages retrieved.
* we can get away with `--level=inf` because the site has a straightforward structure. Be careful, this does not work for all sites.
* I would have liked to use a wait on this to avoid slamming the web server, but `wget` won't allow fractional seconds on waits (at least, AFAIK), and a 1 second wait was going to be too long for my purpose.

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
