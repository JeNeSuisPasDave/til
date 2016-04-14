# Push a new local branch to a remote Git repository and track it too

If you have a local branch that is not tracked in the upstream repository, perhaps created by `git checkout -b topic-newfeature`, you can push that local branch to the remote repo and start tracking the remote repo with this command:

```bash
git push -u origin topic-newfeature
```

More details can be found here: [http://stackoverflow.com/a/6232535/1392864](http://stackoverflow.com/a/6232535/1392864).
