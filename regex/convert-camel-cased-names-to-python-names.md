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
