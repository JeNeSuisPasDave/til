# Display a string as hex or escaped characters

On Unix systems (e.g. FreeBSD, Linux, OS X/macOS) you can display a string representation in hexadecimal, octals, escaped "C" characters, and other encodings. This can be useful if you are trying to find that hidden Bell characters or carriage return.

Try `man od` for all the gory details, or just do:

```bash
echo -n "${mystring}" | od -c
echo -n "${mystring}" | od -t x1
```

For example:

```nohighlight
$ export WAT=abcdefghijk
$ echo -n ${WAT} | od -c
0000000    a   b   c   d   e   f   g   h   i   j   k
0000013
$ echo -n ${WAT} | od -t x1
0000000    61  62  63  64  65  66  67  68  69  6a  6b
0000013
```
