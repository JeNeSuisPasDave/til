# Copy file from another branch

If you are in one branch, and need to just copy a file that exists in another branch, then you can use the command:

```bash
git checkout otherbranch <relative_file_path>
```

Of course, if there is a remote repo then `otherbranch` needs to be fetched and up to do date. Or you can checkout from the remote repo, like this:

```bash
git checkout origin/otherbranch <relative_file_path>
```

You can also pull from a specific commit, like so:

```bash
git checkout <commit_hash> <relative_file_path>
```

More details and variations here: [http://stackoverflow.com/questions/307579/how-do-i-copy-a-version-of-a-single-file-from-one-git-branch-to-another](http://stackoverflow.com/questions/307579/how-do-i-copy-a-version-of-a-single-file-from-one-git-branch-to-another)

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
