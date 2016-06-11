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
