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

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
