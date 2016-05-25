# Copy a new upstream remote branch to the origin remote

Suppose you have a forked repo, with remote `origin`, associated with the original repo (from which the fork was created) with remote `upstream`. In the original repo (`upstream`) a new branch appears and you want to bring it into your forked repo (`origin`). How do you do that? Here's one way (assuming a branch named `topic/new-feature`:

```bash
git fetch --all
git checkout -b topic/new-feature --track upstream/topic/new-feature
git push origin topic/new-feature
git branch topic/new-feature --set-upstream-to origin/topic-new-feature
```

I sometimes throw in a `git reset --hard upstream/topic/new-feature` before the push to `origin` (after the `git checkout -b ...`).
