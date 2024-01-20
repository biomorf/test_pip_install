#!/bin/sh
###
TODO test

fdupes -rn \
	~/programming/snippets/ \
	~/programming/snippets_back/ \
	| grep -Z "snippets_back" | xargs -0 -d '\n' rm

### OR:
fdupes ~/programming/snippets/ ~/programming/snippets_back/ -rn > ../list
cat ../list | grep -Z "snippets_back" | xargs -0 -d '\n' rm

