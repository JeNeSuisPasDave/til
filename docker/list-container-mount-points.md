# List the mounted volumes of a container

You can list the mount points of all the mounted volumes of a container with this command:

```bash
docker inspect --format='{{range $k, $v := .Mounts}}{{(index $v).Destination}}{{"\n"}}{{end}}' container-name
```

Output looks something like:

```nohighlight
/mnt/watfor
/mnt/watfiv
```

This includes any volumes created with the `-v` option and added with the `--volumes-from` option of the `docker run` or `docker create` command.

In contrast, you can list the mount points of configured volumes, the volumes created with the `-v` option, with this command:

```bash
docker inspect --format='{{range $k, $v := .Config.Volumes}}{{$k}}{{"\n"}}{{end}}' delme2
```
