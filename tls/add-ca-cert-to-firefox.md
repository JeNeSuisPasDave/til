# Add CA certificate to Firefox

_Tested with Firefox 50.1.0 on OS X El Capitan (10.11.6)._

Go to Preferences and select _Advanced_ in the nav bar on the left. Then select _Certificates_ in the nav bar on the top.

Click the View Certificates button and, in the resulting dialog, click the Import button. Browse to the CA certificate file (e.g., `~/trash/rootCAcert.pem`) and import it. When prompted, check "Trust this CA to identify websites", and click OK to confirm the change. Click OK again to close the View Certificates dialog.
