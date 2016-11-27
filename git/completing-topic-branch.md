# Git steps after completing a topic branch

First, squash all the commits into one single commit.

```bash
git rebase --interactive dev
```

Then reset the commit time to right now, rather than the timestamp of the first commit in the topic branch.

```bash
git commit --amend --no-edit --reset-author
```

Now merge the commit into the `dev` branch.

```bash
git checkout dev
git merge --ff-only t-dev/rubyvenv
```

Optionally, merge into the `master` branch.

```bash
git checkout master
git merge --ff-only dev
```

If merged into `master`, then tag it.

```bash
git tag -a "2016-03-17" -m "2016-03-17 Did something important"
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
