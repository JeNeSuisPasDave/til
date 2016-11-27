# Push a new local branch to a remote Git repository and track it too

If you have a local branch that is not tracked in the upstream repository, perhaps created by `git checkout -b topic-newfeature`, you can push that local branch to the remote repo and start tracking the remote repo with this command:

```bash
git push -u origin topic-newfeature
```

More details can be found here: [http://stackoverflow.com/a/6232535/1392864](http://stackoverflow.com/a/6232535/1392864).

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
