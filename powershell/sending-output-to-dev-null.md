# Sending ouput to /dev/null

On Unix systems you can send command output to `/dev/null` to prevent it from being displayed in the terminal window.

You can do the same with Powershell by piping to `Out-Null`. The effect of that is to delete all objects in the pipeline.

See [https://technet.microsoft.com/en-us/library/hh849716.aspx](https://technet.microsoft.com/en-us/library/hh849716.aspx) for more details.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
