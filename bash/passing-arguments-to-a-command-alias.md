# Pass arguments to a command alias

Bash aliases are nice shortcuts for long command strings or arcane command flags. For example, here's a pair of alias that I use to get the current time as an ISO8601-like date and time string into the clipboard:

```bash
alias fdate='date +"%F %R"'
alias fcdate='echo -n `fdate` | pbcopy'
```

When I execute the command `fcdate` at the time of this writing, this string is stored in the clipboard: "2017-02-10 05:14".

But the alias operation is just string expansion. It does no processing on the string and cannot reference arguments provided after the alias.

For example, I have a bash function called "longurl" that can take one or two arguments. It's purpose is to take a shortened URL, or otherwise redirected URL, and report the URL at the end of the chain of redirection, i.e., the "lengthened" URL. (For details, see my blog post: [A CLI URL lengthener][post].)

[post]: https://develves.net/blogs/asd/2016-06-25-cli-url-lengthener/

The function returns an integer return code to indicate success or failure and it stores the lengthened URL in a global variable "longurl" (yep, that's the same name as the function).

To use that function I would have to do this command sequence:

```bash
longurl "https://pic.twitter.com/EJFvvD5x3A" && echo "" && echo "$longurl"
```

If I wanted to pipe the output into `pbcopy` I'd do:

```bash
longurl "https://pic.twitter.com/EJFvvD5x3A" && echo -n "$longurl" | pbcopy
```

I wanted to simplify that command sequence, to create an alias for it. This is not straightforward because in the middle of the command is the URL, something that will vary each time the alias is invoked. I need to supply the URL as an argument after the alias name. How to do that?

The answer is to specify the alias as a function definition and subsequent invocation. I alias the execution of that function this way:

```bash
alias lu='function X_(){ longurl "$@" && echo "" && echo "$longurl"; };X_'
alias luc='function X_(){ longurl "$@" && echo -n "$longurl"; };X_'
```

Then I can do `lu https://pic.twitter.com/EJFvvD5x3A` and see that the ultimate URL is `https://twitter.com/MachinePix/status/828428492744249344/photo/1`.

Or I can resolve the shortened URL and put the result in the clipboard with `luc https://pic.twitter.com/EJFvvD5x3A | pbcopy`.

## Credits

I discovered this technique in this Slashdot answer: http://stackoverflow.com/a/22684652/1392864

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
