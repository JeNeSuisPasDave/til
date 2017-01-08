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


