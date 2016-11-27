# Convert camelCased names to Python names

I needed to convert some Python code to conform to PEP8 and PEP257. I had hundreds of test methods with camel-cased names. For example

```python
def testParseInfoInvalidArgs(self):

def testParseInvalidArgs(self):

def testParseInvalidSubCommand(self):
```

And I wanted the test method names to change to Python names. For example:

```python
def test_parse_info_invalid_args(self):

def test_parse_invalid_args(self):

def test_parse_invalid_sub_command(self):
```

I changed the method names using Sublime Text 3 with regex find and replace.

The match pattern I used was `(def test.*)([A-Z]+)` and the replace pattern was `\1_\L\2`. I just ran that global change repeatedly until it found no more matches.

A better match pattern might be `(def test[^A-Z]*)([A-Z]+)` because that would match "testACLwithSomething" and the replace pattern would convert "`ACL`" to "`_acl`"; the patterns in the previous paragraph would have generated "`_a_c_l`" over repeated executions.

---

&copy; 2016 Dave Hein

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This <span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" rel="dct:type">work</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/JeNeSuisPasDave/til" property="cc:attributionName" rel="cc:attributionURL">Dave Hein</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
