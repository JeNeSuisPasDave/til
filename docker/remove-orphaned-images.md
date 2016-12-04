# Remove orphaned images

_I found this tip here: [https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172](https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172)_

Orphaned images are untagged images that do not have any tagged offspring. You can find these images using the command `docker images -f dangling=true`.

>**Note:** Data volumes that are not attached to a running container will look like orphaned images. If you remove all orphaned images, then you may be destroying data volumes that you meant to keep. Be careful. And make sure you have backups of everything you care about before proceeding.

You can remove orphaned images using this `bash` command:

```bash
docker rmi $(docker images -f dangling=true -q)
```

## Update ... nice cleanup function

_(Update 2016-12-04T14:48:43-0600.)_

I found a nice Bash function that _first_ blows away stopped containers and _then_ removes dangling images.

```bash
# found this nice image/container cleanup script here:
# http://stackoverflow.com/a/32723127/1392864
#
dkr_cleanup_unused() {
  docker rm -v $( docker ps --filter status=exited -q 2> /dev/null ) 2> /dev/null
  docker rmi $( docker images --filter dangling=true -q 2> /dev/null ) 2> /dev/null
}
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
