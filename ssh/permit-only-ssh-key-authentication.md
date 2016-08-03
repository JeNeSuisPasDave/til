# (ssh server) Permit only SSH key authentication

To avoid security risks associated with account and password guessing, it is safest to disable password authentication and rely only on public keys to authenticate authorized users.

> The only downside with this approach is that the client's public key must be appended to the server account's `~/.ssh/authorized_keys` file. Some secure mechanism must be provided to perform that operation. Some such mechanisms are:

> * A secure website that can authenticate the client user offers a mechanism to accept the public key from the client user and then add it to the server account's `authorized_keys` file.
> * A secure website generates the keypair on behalf of the client user, appends the public key to the `authorized_keys` file, and allows the client user to download the public and private key (and the server should discard the generated key pair after they are downloaded).
> * Server admin user and client user establish some secure and mutually acceptable side-channel key exchange (like meeting physically and swapping USB sticks).

On an Ubuntu server running `sshd`, you prevent the SSH daemon from accepting passwords by setting this line in the `/etc/ssh/sshd_config` file:

```nohighlight
PasswordAuthentication no
```

After making the change and saving the config file, restart the SSD daemon to put the changes in effect.

```bash
sudo systemctl restart ssh
```
