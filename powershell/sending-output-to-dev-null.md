# Sending ouput to /dev/null

On Unix systems you can send command output to `/dev/null` to prevent it from being displayed in the terminal window.

You can do the same with Powershell by piping to `Out-Null`. The effect of that is to delete all objects in the pipeline.

See [https://technet.microsoft.com/en-us/library/hh849716.aspx](https://technet.microsoft.com/en-us/library/hh849716.aspx) for more details.