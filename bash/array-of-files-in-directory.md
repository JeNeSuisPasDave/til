# Make an array containing the files in a directory

This command will store all the files in a directory into a bash array variable. It isn't very smart. For instance, it doesn't filter out directories or list hidden files (those that start with a ".").

```bash
RBENV_PLUGINS_=( $HOME/.rbenv/plugins/* )
```
