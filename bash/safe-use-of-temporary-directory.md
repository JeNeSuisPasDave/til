# How to create and safely use a temporary directory

_Tested on OS X El Capitan (10.11.6)._

Sometimes you need to create a temporary directory and populate it with files. Perhaps you just need some scratch space, or perhaps you are building up a file system fragment to be transferred to a Docker image.

In either case, you want to make sure you clean up after yourself. Whether the Bash script ends cleanly or not, you want to make sure all those files you created in the temp directory are gone when the script has terminated. Otherwise you just end up filling your persistent store with garbage.

Here's a two-line example that shows how to establish a temporary directory, and how to ensure that it is cleaned up no matter how the script exits.

```bash
TD_=mktemp -dt "$(basename "$0").XXXXXX"
trap "rm -r $TD_" EXIT
```

`trap` is a builtin command of the Bash shell. That statement makes sure that when the script EXITs the command `rm -rf $TD_` is executed. You want to set the trapjust after creating the temporary directory to avoid any window in which an exit can happen without cleaning up the temporary directory.

I like to specify `rm -r` rather than `rm -rf` any time I can, just to avoid inadvertent destruction.

## Credits

I got these commands and tips from the comments to [this Slashdot answer: http://stackoverflow.com/a/10983009/1392864](http://stackoverflow.com/a/10983009/1392864)

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
