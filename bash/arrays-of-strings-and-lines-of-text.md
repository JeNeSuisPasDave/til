# Arrays of strings and lines of text

It is a little tricky dealing moving between string arrays and text lines. Sometimes you have to manipulate IFS (the _internal field separator_ builtin variable) to properly parse strings and join array elements.

## strings to array

Suppose we start with an array of some strings:

```bash
parts=( "part one (1)" "part two (2)" "part three (3)" )
```

## arrays to lines of text

Now, suppose we want to convert that to lines of text, perhaps to run through `egrep`. The way to do that, the one way that works, is to set the special shell variable IFS to be a newline, like this:

```bash
oldIFS=$IFS
IFS=$'\n'
lines="${parts[*]}"
IFS=oldIFS
echo "$lines"
```

The use of the double quotes cause Bash to use the first character of the IFS string to join the array elements when expanding the variable; if double quotes were not used, then a space is used to join the elements. And `[*]` is used rather than `[@]` because `[@]` will always join elements with a space, regardless if whether the variable is expanded within double quotes.

However, that pattern of saving and restoring IFS is error prone. Moreover, IFS is a global variable so care is needed to avoid unintended side effects when changing it.

A clean way of handling this is to take advantage of the ability to assign variables before a command. Something like this, which scopes the IFS change to just the function call:

```bash
function arg_per_line() {
  local vars_=( "$@" )
  arg_per_line="${vars_[*]}"
  return 0
}

IFS=$'\n' arg_per_line "${parts[@]}"
```

After the call to `arg_per_line`, the IFS value is what it was before the call.

But that nice scoping only occurs if the IFS assignment precedes a _command_. It doesn't work if it precedes another variable assignment, with no command given, then the scope of the variable change is the current scope and will be seen in subsequent commands.

So this example is bad practice because will leave IFS changed:

```bash
IFS=$'\n' lines="${parts[*]}"
echo "$lines"
```

And this next example doesn't change IFS in the current scope, but it also doesn't work. The tokens aren't joined by `'\n'`, because the IFS variable assignment occurs _after_ the expansion of `${parts[*]}`:

```bash
IFS=$'\n' echo "${parts[*]}"
```

## lines of text to arrays

The use of IFS is also important when splitting text lines into array elements, like this:

```bash
lines=$'part one (1)\npart two (2)\npart three (3)'
IFS=$'\n'
parts=( ${lines} )
```

## example

Here's an example bash script that shows most of the variations discussed above and shows the state of IFS before and after each variation ...

```bash
#! /bin/bash
#

function arg_per_line() {
  local vars_=( "$@" )
  arg_per_line="${vars_[*]}"
  return 0
}

parts=( "part one (1)" "part two (2)" "part three (3)" )

unset IFS
echo ""
echo -n "IFS is: " && echo -n "$IFS" | od -a && echo ""
echo "default IFS ..."
echo "${parts[*]}"
echo -n "IFS is now: " && echo -n "$IFS" | od -a && echo "" && echo ""

unset IFS
parts=( "part one (1)" "part two (2)" "part three (3)" )
echo -n "IFS is: " && echo -n "$IFS" | od -a && echo ""
echo "IFS set before command ..."
IFS=$'\n' echo "${parts[*]}"
echo -n "IFS is now: " && echo -n "$IFS" | od -a && echo "" && echo ""

unset IFS
echo ""
echo -n "IFS is: " && echo -n "$IFS" | od -a && echo ""
echo "IFS set before variable assignment ..."
IFS=$'\n' ppp="${parts[*]}"
echo "$ppp"
echo -n "IFS is now: " && echo -n "$IFS" | od -a && echo "" && echo ""

unset IFS
echo ""
echo -n "IFS is: " && echo -n "$IFS" | od -a && echo ""
echo "IFS set before function call ..."
IFS=$'\n' arg_per_line "${parts[@]}"
echo "$arg_per_line"
echo -n "IFS is now: " && echo -n "$IFS" | od -a && echo "" && echo ""

unset IFS
```

... and the output of that script ...

```nohighlight
IFS is:
default IFS ...
part one (1) part two (2) part three (3)
IFS is now:

IFS is:
IFS set before command ...
part one (1) part two (2) part three (3)
IFS is now:


IFS is:
IFS set before variable assignment ...
part one (1)
part two (2)
part three (3)
IFS is now: 0000000   nl
0000001



IFS is:
IFS set before function call ...
part one (1)
part two (2)
part three (3)
IFS is now:

```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
