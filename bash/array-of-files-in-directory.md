# Make an array containing the files in a directory

This command will store all the files in a directory into a bash array variable. It isn't very smart. For instance, it doesn't filter out directories or list hidden files (those that start with a ".").

```bash
RBENV_PLUGINS_=( $HOME/.rbenv/plugins/* )
```

If you were willing to launch a process, you could use ls to be more specific. For example, this will list hidden files but not current or parent directory:

```bash
IFS=$'\n' RBENV_PLUGINS_=( $( ls -c1 -A ) )
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
