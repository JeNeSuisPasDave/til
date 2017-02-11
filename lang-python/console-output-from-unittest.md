# Produce console output from a unit test

Unit tests generally swallow console output, especially stdout.

That makes it difficult to troubleshoot problems uncovered by failing unit tests. But you can using the `logging` library to produce formatted output.

Just `import logging as log` and then do `log.warn("{0}", something.different)`.  Warnings are sent do stderr and would normally not be trapped by the unittest framework.

If your test is intercepting stderr, then you may need to be a bit more sophisticated in your use of the logging library.

## Credits

That, and more, can be found in [this Slashdot answer](http://stackoverflow.com/a/30038630/1392864).

---

&copy; 2017 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
