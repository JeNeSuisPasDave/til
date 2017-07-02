# Delete a topic branch

The main development branch is usually called `master`. If you have multiple releases of the project, then you usually have a distinct branch for each release, e.g. `1.0`, `1.1`, `1.1.1`, `1.2`. If you are working on a change that may be an experiment, or may take a few days, then you might create a _topic branch_ from the current `master` and do the work there.

Topic branches are often pushed to a remote repository. This is done so there is a backup of the local branch (you don't want to lose work to a hard disk crash or human error), or so that multiple developers can collaborate on the work.

If you merge that topic branch back into `master` (see [Git steps after completing a topic branch](../git/completing-topic-branch.md)) then you probably want to get rid of the topic branch. That's straightforward if you have not pushed it to a remote repository, and just a little less simple if you have.

## Delete the local topic branch

Make sure the current branch is `master`, or at least some other branch than the one you want to delete. Delete the topic branch using `git branch -d`; the example below deletes the topic branch `t-something`.

```bash
git branch -d t-something
```

## Delete the remote topic branch

If you had pushed the topic branch to the remote repository then you can delete the remote branch with this command.

```bash
git push origin :t-something
```

Other developers will see the local topic removed when they sync their local repo using something like:

```bash
git fetch --all --recurse-submodules
git remote prune origin
```
