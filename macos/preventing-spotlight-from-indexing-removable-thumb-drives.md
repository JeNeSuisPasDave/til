# Preventing Spotlight from indexing removable thumb drives

When you plug a USB thumb drive into your Mac, Spotlight will immediately start building an index of the files on the drive. If it is a large drive, with lots of files, then your Mac will get quite busy and the drive will get accessed quite a bit.

Generally you don't care to have Spotlight index removable media, at least not thumb drives. There's a couple ways to prevent the indexing.

The best way is to add a file called `.metadata_never_index` to the root of the drive. Then the next time you insert the drive, Spotlight will see that file and won't attempt to index the drive.

You create that file with a command like this:

```bash
cd /Volumes/MyThumbDrive/
touch .metadata_never_index
```

That will work the next time you insert the drive into any Mac.

To stop ongoing indexing of the drive on a single Mac, first check the status with a `mdutil -s` command. Here's an example (thumb drive named "Media128G"):

```nohighlight
~# mdutil -s /Volumes/Media128G
/Volumes/Media128G:
	Indexing enabled. 
```

Then you can issue the `mdutil -i off` command to stop the indexing, like this:

```nohighlight
~# mdutil -i off /Volumes/Media128G
/Volumes/Media128G:
2017-06-24 10:44:20.380 mdutil[89908:6130212] mdutil disabling Spotlight: /Volumes/Media128G -> kMDConfigSearchLevelFSSearchOnly
	Indexing and searching disabled.
~# mdutil -s /Volumes/Media128G/
/Volumes/Media128G:
	Indexing and searching disabled.
```

