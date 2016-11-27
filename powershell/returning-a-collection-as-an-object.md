# Returning a collection as an object

If you return a collection object from a function you will end returning an enumerator of the collection rather than the collection object itself. Powershell just does that on the return value; there's no way to change that behavior.

This example function returns nothing.

```powershell
Function Do-Something {
    $msg = New-Object "System.Collections.Generic.List[String]"
    $msg.Add("One thing")
    $msg.Add("And another")

    return , $msg
}
```

The workaround is to wrap the collection object in another collection, using the so-called _unary comma_.

Changing the return statement to mix in a unary comma then causes the function to return a List of strings, with a Count property---a proper generic List object.

```powershell
Function Do-Something {
    $msg = New-Object "System.Collections.Generic.List[String]"
    $msg.Add("One thing")
    $msg.Add("And another")

    return , $msg
}
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
