# Giving a standard user account SUDO rights

I use a standard user account, one with no administrative privileges, for all my normal work, including software development. I have another account that I use for administrative tasks, like installing software, system configuration, et cetera. I do this for security; for example, if I trigger a drive by attack while browsing the web, the attacking malware--which is running under my standard user account--won't have privileges to do much damage.

However, sometimes it is helpful to be able to `sudo` a command from that standard user account. I find that it is rarely necessary, but I have found the need on occasion.

What is needed is a way to grant the standard user account privilege to run `sudo`, but without granting that user account full administrative rights. On OS X, or macOS, the way to do that is with the command `sudo visudo`. The `visudo` command lets you edit the so-called "sudoers" file that the system uses to decide who gets to use `sudo`.

So, login as an administrative user and open a terminal window, or ssh into the system with an administrator account. Then run `sudo visdudo`. You'll see a section that looks like this:

```
# User privilege specification
root    ALL=(ALL) ALL
%admin  ALL=(ALL) ALL
```

Add a line after the `%admin` line and specify your standard user account to look just like the one for `root`. For example, if my standard user account was `joe`, then I'd add a line as in this example:

```
# User privilege specification
root    ALL=(ALL) ALL
%admin  ALL=(ALL) ALL
joe     ALL=(ALL) ALL
```

Then save the file (`:w` ... it's vi/vim).

See this [Stack Exchange reply][instructions] for a bit more detailed instructions.

[instructions]: https://apple.stackexchange.com/a/76094/184353
