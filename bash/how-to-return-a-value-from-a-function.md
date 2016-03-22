# How to return a value from a function

Bash functions return an integer value. If you want to return something else then you'll have to use a global variable. And that means documenting the return variable and choosing something unlikely to conflict with a variable that the author of any consuming script might use for another purpose. Tricky and fragile.

It turns out that bash has a separate namespace for functions and variables (thanks to [http://stackoverflow.com/a/30042245/1392864](http://stackoverflow.com/a/30042245/1392864)). So, if the function just sets a global variable having the same name as the function, then we have a nice self-documenting naming convention for function return variables. And it is also less likely that there will be a conflict between script variables and the function return variable names (because functions tend to have verb or verb-noun names, while variables tend to have noun names).

An example:

```bash
parse_version() {
  # Initialize result and local variables
  #
  local STD_VSN_=( "0" "0" "0" "" )
  parse_version=( ${STD_VSN_[@]} )

  # ... do stuff ...

  # Set global $parse_version to result and
  # get out
  #
  parse_version=( ${STD_VSN_[@]} )
  return 0
}

parse_version "1.2.3-p456"
if (( 0 != $? )); then
  echo "ERROR: failed to parse version."
  exit 2
fi
VSN_PARTS_=( ${parse_version[@]} )
echo "MAJOR: ${VSN_PARTS_[0]}"
echo "MINOR: ${VSN_PARTS_[1]}"
echo "PATCH: ${VSN_PARTS_[2]}"
echo "  SUB: ${VSN_PARTS_[3]}"
```
