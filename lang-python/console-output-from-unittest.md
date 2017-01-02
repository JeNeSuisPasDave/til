# Produce console output from a unit test

Unit tests generally swallow console output, especially stdout.

That makes it difficult to troubleshoot problems uncovered by failing unit tests. But you can using the `logging` library to produce formatted output.

Just `import logging as log` and then do `log.warn("{0}", something.different)`.  Warnings are sent do stderr and would normally not be trapped by the unittest framework.

If your test is intercepting stderr, then you may need to be a bit more sophisticated in your use of the logging library.

## Credits

That, and more, can be found in [this Slashdot answer](http://stackoverflow.com/a/30038630/1392864).
