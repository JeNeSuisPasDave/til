# Creating a soft link to a directory

I always get confused about which argument of the `ln -s` command is which. In other words, which is the existing directory path and which is the new link that I'm trying to create. The man page eventually gets around to the main point, which is:

> Given one or two arguments, ln creates a link to an existing file _source_file_.  If _target_file_ is given, the link has that name; _target_file_ may also be a directory in which to place the link; otherwise it is placed in the current directory.  If only the directory is specified, the link will be made to the last component of _source_file_.

So `ln -s source_file target_file` will create a new link file called `target_file` in the current directory; it points to the existing file or directory `source_file`.

Thus:

```bash
ln -s existing_file link_name
ln -s existing_dir link_name
```
