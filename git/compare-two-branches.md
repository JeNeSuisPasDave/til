# Compare two branches

## comparing just one file

You can see the differences between one file across two branches by doing any of these three things:

```bash
git diff branch1..branch2 filepath
git diff branch2..branch1 filepath
git diff branch1...branch2 filepath
```

The first shows you what is branch2 that is not in branch1; the second shows you what is in branch1 that is not in branch2; the third shows the difference between the last common commit and branch2.

## comparing branches

You can see the differences between branches by doing any of these three things:

```bash
git diff branch1..branch2
git diff branch2..branch1
git diff branch1...branch2
```

As before, the first shows you what is branch2 that is not in branch1; the second shows you what is in branch1 that is not in branch2; the third shows the difference between the last common commit and branch2.

## references

See especially [http://stackoverflow.com/a/5257065/1392864](http://stackoverflow.com/a/5257065/1392864) for a good explanation of how the branch specifications work. The important point is that "only ever shows you the difference between the states of the tree between exactly two points in the commit graph".

See also [http://stackoverflow.com/a/9834872/1392864](http://stackoverflow.com/a/9834872/1392864).

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
