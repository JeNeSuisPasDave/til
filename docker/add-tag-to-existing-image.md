# Adding a tag to an existing image

Sometimes you want to add a tag to an existing docker container image. Here's how:

```bash
docker tag 0e5574283393 myproject/myimage:sometag1.0
```

The first argument is the identifier of the image, which can be an image ID or image name or impage name with tag, etc. The second argument is the image ID and tag; if the tag is missing it will default to "latest".

You can read the `docker tag` [documentation](https://docs.docker.com/engine/reference/commandline/tag/) for more info. At the moment it does explain that the 'tag' is the second argument, hence this TIL.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
