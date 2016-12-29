# Add CA certificate to Firefox

_Tested with Firefox 50.1.0 on OS X El Capitan (10.11.6)._

Go to Preferences and select _Advanced_ in the nav bar on the left. Then select _Certificates_ in the nav bar on the top.

Click the View Certificates button and, in the resulting dialog, click the Import button. Browse to the CA certificate file (e.g., `~/trash/rootCAcert.pem`) and import it. When prompted, check "Trust this CA to identify websites", and click OK to confirm the change. Click OK again to close the View Certificates dialog.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
