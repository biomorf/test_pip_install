#!/bin/sh
###

### https://serverfault.com/questions/252921/how-to-remove-empty-blank-lines-from-a-file-in-unix-including-spaces
### lines without spaces
cat file.txt | grep . 
cat file.txt | rg -N .
cat file.txt | sed -i '/^$/d'
cat file.txt | awk NF 
cat file.txt | tr -s '\n' '\n'


### lines with spaces
cat file.txt | grep "\S" file.txt
cat file.txt | rg -N "\S"
cat file.txt | sed -i '/^ *$/d' file.txt

### also leading spaces
cat file.txt | xargs -n1
