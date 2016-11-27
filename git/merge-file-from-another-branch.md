# Merge file from another branch

If you are in one branch, and need to merge another branch's version of that same file into the current branch, then you can use the command:

```bash
git checkout -p otherbranch <relative_file_path>
```

Of course, if there is a remote repo then `otherbranch` needs to be fetched and up to do date. Or you can checkout from the remote repo, like this:

```bash
git checkout origin/otherbranch <relative_file_path>
```

You can also merge from a specific commit, like so:

```bash
git checkout -p <commit_hash> <relative_file_path>
```

More details and variations here: [http://stackoverflow.com/questions/13711455/how-can-i-merge-a-specific-file-from-one-branch-into-another-branch-in-git](http://stackoverflow.com/a/13712429/1392864). And here: [http://stackoverflow.com/questions/449541/how-do-you-merge-selective-files-with-git-merge](http://stackoverflow.com/a/1355990/1392864).

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
