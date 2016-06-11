# Open a shell in a running container

If you want to open a Bash or Ash shell in a container that's already running then you can do this:

```bash
docker exec -t -i container_name /bin/bash
```

or

```bash
docker exec -t -i container_id /bin/ash
```

Make sure you exit the shell (to avoid leaving a shell process hanging around in the container).

Credit for this TIL here: [http://askubuntu.com/a/543057/336674](http://askubuntu.com/a/543057/336674).