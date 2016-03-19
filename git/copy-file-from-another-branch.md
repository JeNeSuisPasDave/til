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
