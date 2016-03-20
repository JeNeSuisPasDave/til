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
