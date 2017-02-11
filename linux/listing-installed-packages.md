# Listing installed packages on Ubuntu

A simple list of the packages can be had with this command:

```bash
dpkg --get-selections | grep -v deinstall
```

On Ubuntu 14.04 and later, a more complex list can be had from:

```bash
apt list --installed
```

## Credit

Found these commands in [this StackOverflow answer][answer].

[answer]: http://askubuntu.com/a/17829/336674

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

