# (ssh client) Associate a pseudo-hostname with an SSH key

When using ssh to connect to a server that requires authentication via SSH key you would normally need to specify the user, the hostname, and the private key file. That looks something like this:

```bash
ssh -i ~/.ssh/myaccount-id_rsa myaccount@theirserver.example.com
```

or

```bash
ssh -i ~/.ssh/otheraccount-id_rsa -l otheraccount theirserver.example.com
```

That's a lot to type each time you want to `ssh` or `scp` (which uses similar command options). You can simplify the command line quite a bit by using a psuedo hostname, specified in the per-user ssh client config file `~/.ssh/config`. It's best to show some examples, but the config file specifiation can be found using `man sshd_config`.

To show how this works, here is the config file specification for the two examples above, using two psuedo hostnames 'theirserver' and 'theirserver-oa':

```nohighlight
Host theirserver
  User myaccount
  HostName theirserver.example.com
  IdentityFile ~/.ssh/myaccount-id_rsa

Host theirserver-oa
  User otheracount
  HostName theirserver.example.com
  IdentityFile ~/.ssh/otheraccount-id_rsa
```

With that config in place I can login to the server using either of these commands, each corresponding to one of the original examples above:

```bash
ssh theirserver
ssh theirserver-oa
```

As I mentioned, this also makes `scp` commands simpler, for example:

```bash
scp mydata.csv theirserver:data/mydata.csv
scp shared-data.csv theirserver-oa:share/data/shared-data.csv
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
