# Trim whitespace from variable

_Tested on OS X El Capitan (10.11.6)._

Some commands produce results with undesirable whitespace. For example the `wc` command produces leading white space, e.g.:

```nohighlight
$ echo "one two three" | wc -w
       3
```

The most portable way to trim leading and trailing whitespace is to use `sed` like this: `echo $var | sed -e 's/^ *//' -e 's/ *$//'`.  For example:

```nohighlight
$ echo "one two three" | wc -w | sed -e 's/^ *//' -e 's/ *$//'
3
```

## Credits

I found that particular `sed` formulation in [this comment](https://www.cyberciti.biz/faq/bash-remove-whitespace-from-string/#comment-77884) to a blog post on the topic of whitespace trimming.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
