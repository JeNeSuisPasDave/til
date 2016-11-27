# Add a remote for the original repo of a forked repo

The scenario is that you forked a repository (on [GitHub](https://github.com) or [BitBucket](https://bitbucket.org/)) and you want to be able to pull changes from that original repo into your fork of the repo.

Look at the branches and remotes in your repository using `branch -ra -vv`. That will should you all local and remote branches (via `-ra`), and will give the remote branch mapping for any local branches that are tracking remote branches (via `-vv`).

For example:

```nohighlight
$ git branch -ra -vv
  dev                                 1e87437 [origin/dev] Added section on ssh-agent.
  master                              1e87437 [origin/master] Added section on ssh-agent.
* t-dev/llvmrecipe                    38b0337 [origin/t-dev/llvmrecipe] Added recipe for LaTex runner & base Ubuntu image
  t-dev/pythonrecipe                  c500144 [origin/t-dev/pythonrecipe] Ignore sublime workspace file
  remotes/origin/HEAD                 -> origin/master
  remotes/origin/dev                  1e87437 Added section on ssh-agent.
  remotes/origin/master               1e87437 Added section on ssh-agent.
  remotes/origin/t-dev/llvmrecipe     38b0337 Added recipe for LaTex runner & base Ubuntu image
  remotes/origin/t-dev/pythonrecipe   c500144 Ignore sublime workspace file
```

To add the original repo, from which your repo was forked, use the commands:

```bash
git remote add upstream <remote-repo-url>
git fetch upstream
```

The repository name "upstream" is a common convention, but you can use any valid repository name.

Once done, you'll see the original remote repo in the list of branches. For example:

```nohighlight
$ git branch -ra -vv
  dev                                 1e87437 [origin/dev] Added section on ssh-agent.
  master                              1e87437 [origin/master] Added section on ssh-agent.
* t-dev/llvmrecipe                    38b0337 [origin/t-dev/llvmrecipe] Added recipe for LaTex runner & base Ubuntu image
  t-dev/pythonrecipe                  c500144 [origin/t-dev/pythonrecipe] Ignore sublime workspace file
  remotes/origin/HEAD                 -> origin/master
  remotes/origin/dev                  1e87437 Added section on ssh-agent.
  remotes/origin/master               1e87437 Added section on ssh-agent.
  remotes/origin/t-dev/llvmrecipe     38b0337 Added recipe for LaTex runner & base Ubuntu image
  remotes/origin/t-dev/pythonrecipe   c500144 Ignore sublime workspace file
  remotes/upstream/dev                1e87437 Added section on ssh-agent.
  remotes/upstream/master             1e87437 Added section on ssh-agent.
  remotes/upstream/t-dev/llvmrecipe   8a9a186 Adding some more PS examples
  remotes/upstream/t-dev/pythonrecipe c500144 Ignore sublime workspace file
```

To keep your local git cache up to date with the remotes, you can do `git fetch --all` or `git fetch --all --recurse-submodules`, optionally followed by `git remote prune <remote-name>` for each remote.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
