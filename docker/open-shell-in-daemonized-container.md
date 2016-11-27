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

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
