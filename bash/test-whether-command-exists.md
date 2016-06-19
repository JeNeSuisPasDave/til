# Test whether a command exists

To check whether a command exists you might be tempted to use `which`. But don't do that---it launches another process. More efficient would be use use `type`, like so:

```bash
if type something >/dev/null 2>&1; then
  # use it
  pass
else
  # don't use it
  echo "something not found"
fi
```

You could also use `hash` instead of `type`.

If you want to stay POSIX compliant then you should use `command -v` instead of `type` or `hash` (neither of which are well-defined by POSIX, or so I've [heard][credit]).

## Credit

Credit for this one goes to this StackOverflow answer: [http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script#677212][credit].

[credit]: http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script#677212
