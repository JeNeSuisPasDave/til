# Adding a tag to an existing image

Sometimes you want to add a tag to an existing docker container image. Here's how:

```bash
docker tag 0e5574283393 myproject/myimage:sometag1.0
```

The first argument is the identifier of the image, which can be an image ID or image name or impage name with tag, etc. The second argument is the image ID and tag; if the tag is missing it will default to "latest".

You can read the `docker tag` [documentation](https://docs.docker.com/engine/reference/commandline/tag/) for more info. At the moment it does explain that the 'tag' is the second argument, hence this TIL.
