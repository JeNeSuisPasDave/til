# What is the equivalent of the Unix touch utility?

From a PowerShell command prompt, how do you do `touch`? On Unix and Linux systems, the `touch` utility will create an empty (zero length) file, or it updates the modification time of an existing file.

For example `touch wat.txt` creates a file `wat.txt` in the current directory. If I fill that file with text and then try the same command again, the contents are preserved but the modification date is updated to current time.

So how to do this in PowerShell?

The command `echo $null >> wat.txt` does the trick. It provides the same behavior as described above for `touch`. But it feels _dangerous_; if you use `>` instead of `>>` then you'll wipe out the file content.

Much better to make a cmdlet that ensures you will do no harm. Here is my current favorite implementation.

```powershell
Function Touch-File {
  Param(
    [Parameter(Mandatory=$true)]
    [string]$Path
  )

  if (Test-Path -LiteralPath $Path) {
    (Get-Item -Path $Path).LastWriteTime = Get-Date
  } else {
    New-Item -Type File -Path $Path
  }
}

New-Alias -Name touch -Value "Touch-File"
```

_Note: needs help meta-data. I don't like doing cmdlets without in-source help documenting function and usage, but I don't have a Windows system available at the moment and I want to get this TIL published immediately._

## Credits

Found the _"pipe a $null"_ method in this SuperUser answer: [http://superuser.com/questions/502374/equivalent-of-linux-touch-to-create-an-empty-file-with-powershell#502378](http://superuser.com/questions/502374/equivalent-of-linux-touch-to-create-an-empty-file-with-powershell#502378).

The `Touch-File` implementation is a mash-up of other answers from that SuperUser question, and from various other blogs and Q&A posts on the topic.

If you really want to get comprehensive, see Øyvind Kallstad's example: "[A PowerShell implementation of Touch][compreshensive]

[compreshensive]: (https://communary.net/2014/11/15/a-powershell-implementation-of-touch/)"

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
