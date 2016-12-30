# Remove large objects from a git repo

Sometimes you check something in to a Git repo that you wish you hadn't. Like an ISO file, or maybe a large data file or database backup.

Here's how you can remove such objects from the repo without destroying history or losing tags.

## Caution w.r.t. remote repos

* It's probably best if everyone pushes their local commits to the remote repo before you do this. _This is to avoid synchronization issues after the remote repo history is rewritten._
* It's probably best to pull a fresh, distinct, local repo, make the changes on that, and then push to the remote. _Then your original local copy is still around if you somehow irrevocably damage the remote repo._
* It's also probably best to have everyone get a fresh pull after updating the remotes. It's not clear to me. _This is to avoid synchronization issues after the remote repo history is rewritten._

It's possible Git is so magical that non of those precautions are necessary. Do some experiments before tempting fate.

## Removing ISO image files from the repo

This Bash script does the trick. Run this on each local branch.

```bash
#! /bin/bash
#
# Delete the objects
#
git filter-branch --tree-filter 'git rm -r -f --ignore-unmatch *.iso' --prune-empty --tag-name-filter cat HEAD

# Delete the references and purge the reflog
#
git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all

# Garbage collect all the things
#
git gc --prune=now
```

## Don't forget to update the remote repo

Update the remote repo with these commands. Do it after updating your local branches.

```bash
git push origin --force --all
git push origin --force --tags
```

## Variations

It can take a long time to rewrite all the changes in a long-lived repo. If you know when the large objects crept into the repository, you can specify a range of commits to rewrite, which will speed the process. Something like this:

```bash
git filter-branch --tree-filter 'git rm -r -f --ignore-unmatch *.iso' --prune-empty --tag-name-filter cat 8a9a18631..HEAD
```

You can kill a specfic folder using `'git rm -rf some/folder`, a specific file with `'git rm some/folder/file.big'`.

## Credits

I've seen this and similar in may posts and Slashdot answers, but this blog post, along with it's comments, does a pretty good job: [http://dalibornasevic.com/posts/2-permanently-remove-files-and-folder](http://dalibornasevic.com/posts/2-permanently-remove-files-and-folder)

I recommend reading the post and comments.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
