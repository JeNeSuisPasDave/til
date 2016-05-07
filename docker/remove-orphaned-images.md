# Remove orphaned images

_I found this tip here: [https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172](https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172)_

Orphaned images are untagged images that do not have any tagged offspring.

You can find these images using the command `docker images -f dangling=true`. You can remove orphaned images using this `bash` command:

```bash
docker rmi $(docker images -f dangling=true -q)
```
