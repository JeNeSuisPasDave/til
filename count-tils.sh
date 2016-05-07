#! /bin/bash
#

# Count the markdown files, except for README.md
#
find . -name "*.md" -print | grep -v "README.md" | wc -l
