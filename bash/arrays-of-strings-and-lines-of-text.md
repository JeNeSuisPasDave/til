# Arrays of strings and lines of text

It is a little tricky dealing moving between string arrays and text lines.

Here's how it works, by example

Suppose we start with an array of some strings:

```bash
parts=( "part one (1)" "part two (2)" "part three (3)" )
```

Now, suppose we want to convert that to lines of text, perhaps to run through `egrep`. The way to do that, the one way that works, is this:

```bash
IFS=$'\n' lines="${parts[*]}"
```

The use of the double quotes cause Bash to use the first character of the IFS string to join the array elements when expanding the variable; if double quotes were not used, then a space is used to join the elements. And `[*]` is used rather than `[@]` because `[@]` will always join elements with a space, regardless if whether the variable is expanded within double quotes.

The use of IFS is also important when splitting text lines into array elements, like this:

```bash
lines=$'part one (1)\npart two (2)\npart three (3)'
IFS=$'\n' parts=( ${lines} )
```

After that, we can see some interesting results, confirming the behaviors described above.

```nohighlight
$ echo ${#parts[@]}
3
$ IFS=$'\n' echo ${parts[*]}
part one (1) part two (2) part three (3)
$ IFS=$'\n' echo "${parts[*]}"
part one (1)
part two (2)
part three (3)
$ IFS=$'\n' echo "${parts[@]}"
part one (1) part two (2) part three (3)
```

