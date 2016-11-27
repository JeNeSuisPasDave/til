# List the files in a commit

You can list all the files in a commit using the command:

```bash
git diff-tree --no-commit-id --name-only -r <commit-ish>
```

Where <commit-ish> is a commit id (e.g. `e57fa64b`) or other commit identifier. A good explanation of _commit-ish_ is found here: [http://stackoverflow.com/a/23303550/1392864](http://stackoverflow.com/a/23303550/1392864)

You can also show the status of each file in the command (i.e. add, delete, modify) using the option `--name-status` instead of `--name-only`.

## example

Here is an example that lists the files for the `HEAD^^` commit:

```bash
[t-dev/llvmrecipe]~/Documents/prj/moi/docker-recipes$
git diff-tree --no-commit-id --name-only -r HEAD^^
docker-recipes.sublime-project
howto/windows-git-and-powershell.md
```

Here is an examples that list the files for a different commit, using the commit id and showing the file status:

```bash
[t-dev/llvmrecipe]~/Documents/prj/moi/docker-recipes$
git diff-tree --no-commit-id --name-status -r 0751d5f3
M   .gitignore
A   recipes/Create a new VirtuaBox VM to host Docker Server/README.md
A   recipes/Create a new VirtuaBox VM to host Docker Server/create-vm-docker-server.sh
A   recipes/Create a new VirtuaBox VM to host Docker Server/use-vm-docker-server.src
M   recipes/Docker Demo - simple web app/Dockerfile
M   recipes/Docker Demo - simple web app/README.md
```

## source of this tip

More details and variations of ways to list files in a commit can be found here: [http://stackoverflow.com/a/424142/1392864](http://stackoverflow.com/a/424142/1392864)

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
