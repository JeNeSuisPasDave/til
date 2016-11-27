# Push an existing repo to GitHub

You've got a local Git repository and are ready to publish it on GitHub. Here's how.

1. Create a new repository on GitHub. Do not ask GitHub to set a `README.md` file or a `LICENSE` file or a `.gitignore` file. Those should come from your local repo.
2. Make note of the repository URL.
3. From the root directory of your local repository, make sure you are in the `master` branch, and issue the command:

```bash
git remote add origin <ssh_prefix>/<github_account>/<repo_name>.git
git push -u origin --all
git push origin --tags
```

Note that you'll want to have an `~/.ssh/config` setup to authenticate access. For example:

```
Host github-je
    User git
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/github-jenesuispasdave-id_rsa
```

Given that config, the `git remote add origin` command for this repo would look like:

```bash
git remote add origin github-je:/JeNeSuisPasDave/til.git
```

More details here: [http://stackoverflow.com/questions/6865302/push-local-git-repo-to-new-remote-including-all-branches-and-tags](http://stackoverflow.com/questions/6865302/push-local-git-repo-to-new-remote-including-all-branches-and-tags)

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
