# Appending and Composing Arrays

You can create a new array by composing two or more existing arrays. That works like this:

```bash
one=( "hello" "greetings" "good morning" )
two=( "goodbye" "good night" "ciao" )
one_and_two=( "$one[@]}" "$two[@]" )
```

The result of that is that `one` has 3 elements, `two` has three elements, and `one_and_two` has 6 elements.

You can append to an array by a variation of that composition. For example:

```bash
things=()
things=( "${things[@]}" "one thing" )
things=( "${things[@]}" "after another" )
```

The above statements change `things` from an empty array to a one-element array and then to a two-element array.
