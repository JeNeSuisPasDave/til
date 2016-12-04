# Listing the labels of an image (or container or task)

Docker leverages Go templates to display information about an image (or a container or a task). I find Go templates to be somewhat tricky, perhaps because I'm not familiar with the Go language, at least not yet (circa 2016).

As I work up the Docker learning curve I've accumulated a large and growing set of images. I decided to start adding labels to some of my docker images so that I could use a `--filter` to reduce the list of images to just the few I'm interested in.

To see the set of labels attached to a specific image you must use [the `docker inspect` command][inspect]. Unqualified, that command will spew out a long nested JSON object. To just display the bits you are interested in, you have to use the `--format` option, and that obliges you to learn about [Go templates][gotmp].

[gotmp]: https://golang.org/pkg/text/template/
[inspect]: https://docs.docker.com/engine/reference/commandline/inspect/

After an unsettling amount of trial and and error, and reading and re-reading the documenation, I finally settled on these two variations:

```bash
docker inspect --format='{{range $k, $v := .ContainerConfig.Labels}} {{- $k}}={{$v}}{{printf "\n" -}} {{end}}' datihein/rsync-alpine
```

```bash
docker inspect --format='{{range $k, $v := .ContainerConfig.Labels}} {{- printf "%s = \"%s\"\n" $k $v -}} {{end}}' datihein/rsync-alpine
```

I like the second one best. It outputs something like this:

```nohighlight
net.develves.distro = "alpine"
net.develves.distro-version = "alpine 3.4"
net.develves.examples = "flask-web-development-book"
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
