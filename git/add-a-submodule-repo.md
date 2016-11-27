# Add a submodule repository

I had a need to add `https://github.com/geminabox/geminabox.git` as a submodule in my repository. I did this by using a series of `git submodule` commands:

```bash
git submodule add https://github.com/geminabox/geminabox.git geminabox
git submodule init
git submodule update
```

I wanted a specific tag of the `geminabox` repository to be used, so I checked that out, and then committing the submodule directory:

```bash
cd geminabox
git checkout v0.13.1
cd ..
git add geminabox
git commit -m "Adding geminabox v0.13.1 as a submodule"
```

If I get a fresh pull, or checkout another branch, I will need to do:

```bash
git submodule init
git submodule update
```

`git submodule init` adds the `[submodule "geminabox"]` section to the `.git/config` file.

`git submodule update` will update the submodule files, the local files, or clone the repository if that hasn't been done yet. The current commit will match that committed in the parent repository.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
