# Pairing a Logitech wireless mouse on Ubuntu Desktop

I was installing a small system with Ubuntu Desktop (16.04.1). The keyboard and mouse were both Logitech wireless devices; keyboard was the K750 and the mouse is the M570. The system had the Logitech unity receiver (the one that came with the keyboard) plugged in to a USB port.

When I ran the installer I found that the keyboard worked just fine, but the mouse was not automatically recognized. I was able to install entire using the keyboard, but I need the mouse to do much of anything else.

Fortunately, there exists the command line utility [ltunify](https://git.lekensteyn.nl/ltunify/) which can pair the receiver. The utility's author wrote about it in an "Ask Ubuntu" answer: [http://askubuntu.com/a/114089/336674](http://askubuntu.com/a/114089/336674)

You'll need git and gcc installed. Then you can install `ltunify` by doing:

```bash
mkdir ~/bin
mkdir ~/trash/delme
cd ~/trash/delme
git clone https://git.lekensteyn.nl/ltunify.git
cd ltunify
make install-home
cd ~
```

The run it using `sudo ltunify pair`, which should prompt you to turn the device off and back on. When I did that with the mouse I saw the response: `Found new device, id=0x02 Trackball`. And the mouse started working.

Very nice.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
