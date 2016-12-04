# Listing images with a specific label

I have a large and growing collection of docker images. If I want to restrict the list output to just those images with a particular label, I can do that with the `--filter` option of [the `docker images` command][images].

[images]: https://docs.docker.com/engine/reference/commandline/images/

Here's an example that lists only images that have _a specific label key_. This filter specifies the label "net.develves.examples"; I use that for images I create to try out an example or exercise from a book or tutorial.

```bash
docker images --filter "label=net.develves.examples"
```

This example lists only images with _a label key of a specific value_. This filter specifies just the example images I've associated with a particular book.

```bash
docker images --filter "label=net.develves.examples=flask-web-development-book"
```
