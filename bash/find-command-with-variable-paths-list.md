# Find command with variable paths list

Suppose I want to list all the files in a directory './one' and produce an MD5 hash of each file. I could do that with a Bash command like this:

```bash
find one -type f -exec md5 -r {} \;
```

_(escaping the semi-colon so that it is passed to `exec` rather than being considered a command separator that terminates the `find` command.)_

If I wanted to run `md5` on all the files in a couple directories, "./one" and "./two", I'd just specify both directories before any of the options, like this:

```bash
find one two -type f -exec md5 -r {} \;
```

That works, but really I'm after a hash of all the contents, not a list of file hashes. So I'd just pipe the `find` output into `md5`. Like this:

```bash
find one two -type f -exec md5 -r {} \; | md5
```

Now suppose I'm doing the `find` command inside a function, and the arguments to the function are directory names. There could be a variable number of directory names. I might write a function like this:

```bash
function get_contenthash() {
  local dirs_=( "$@" )
  if (( 0 != ${#dirs_[@]} )); then
    find "${dirs_[@]}" -type f -exec md5 -r {} \; | md5
  fi
}
```

Let's fix that a bit to return the hash string to the caller, rather than sending it to STDOUT:

```bash
function get_contenthash() {
  get_contenthash="0"
  local dirs_=( "$@" )
  if (( 0 != ${#dirs_[@]} )); then
    get_contenthash=$( find "${dirs_[@]}" -type f -exec md5 -r {} \; | md5 )
  fi
}
```

## long line variation

In my Bash scripts, I like to keep the line length to 80 characters or less. Often that means taking a long command and breaking it up into string variables and then mashing up those strings to produce the command. For the above function, that would look something like this:

```bash
function get_contenthash() {
  get_contenthash="0"
  local dirs_=( "$@" )
  if (( 0 != ${#dirs_[@]} )); then
    local cmd_="find ${dirs_[@]} -type f -exec md5 -r {} \;"
    get_contenthash=$( "$cmd_" | md5 )
  fi
}
```

_(and, yes, the original function didn't have long lines. I'm just using it for illustration purposes.)_

But that gets parsed incorrectly and produces "command not found" errors. To see why, try using the `-x` option in the batch script (a _shebang_ line like `#! /bin/bash -x`) on the working version from the previous section and the broken version above.

The workaround is to tokenize the command explicitly, forming the command into an array of tokens rather than a string.

This works:

```bash
function get_contenthash() {
  get_contenthash="0"
  local dirs_=( "$@" )
  if (( 0 != ${#dirs_[@]} )); then
    local cmd_=( "find" "-s" "${paths_[@]}" )
    cmd_=( "${cmd_[@]}" "-type" "f" "-exec" "md5" "-r" "{}" ";" )
    get_contenthash=$( "${cmd_[@]}" | md5 )
  fi
}
```
