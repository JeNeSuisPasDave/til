# How much data is in a directory

The `du` command can be used to determine how much disk space is allocated to a file or directory. The command can be used iteratively to help discover where large disk space use is occurring, perhaps to help identify data that could be archived to save space or to help troubleshoot misbehaving applications or processes.

I find the most useful form of this command to be:

```bash
du -c -h -d 1 ./*
```

* `-c` requests a "grand total" for the allocation of the sum of the files and directories being examined.
* `-h` requests "human readable" sizes (so "23M" instead of 24131593).
* `-d 1` requests that the output only display sizes for files and directories one level deep. This option controls the output, not the analysis; the entire directory tree is examined, but sizes and cumulative sizes are only displayed for items up to 1 level deep.
* `./*` looks at each item in the current directory. If you just use `.` or don't supply a file or directory then the working directory is the "level 1" item; this can be a useful variant.

On my Mac (i.e. on macOS, a.k.a. OS X), to aid in my monthly quest for free disk space, I often use this variant:

```bash
du -c -h -d 1 ~/Documents/*
```

You can get just the grand total by doing:

```bash
du -c -h -d 0 ./*
```

or

```bash
du -c -h -d 0 .
```

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
