# Remove orphaned images

_I found this tip here: [https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172](https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172)_

Orphaned images are untagged images that do not have any tagged offspring. You can find these images using the command `docker images -f dangling=true`.

>**Note:** Data volumes that are not attached to a running container will look like orphaned images. If you remove all orphaned images, then you may be destroying data volumes that you meant to keep. Be careful. And make sure you have backups of everything you care about before proceeding.

You can remove orphaned images using this `bash` command:

```bash
docker rmi $(docker images -f dangling=true -q)
```
