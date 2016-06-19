# Make an array containing the files in a directory

This command will store all the files in a directory into a bash array variable. It isn't very smart. For instance, it doesn't filter out directories or list hidden files (those that start with a ".").

```bash
RBENV_PLUGINS_=( $HOME/.rbenv/plugins/* )
```

If you were willing to launch a process, you could use ls to be more specific. For example, this will list hidden files but not current or parent directory:

```bash
IFS=$'\n' RBENV_PLUGINS_=( $( ls -c1 -A ) )
```
