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
