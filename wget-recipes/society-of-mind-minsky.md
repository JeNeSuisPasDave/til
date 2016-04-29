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
