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
