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

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
