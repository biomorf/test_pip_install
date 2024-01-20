#!/bin/sh
###

# aim is to 
# 1. make list of dup files with all files in set except the first one
# 2. filter files NOT in $1 dir
# 3. filter non-empty lines in list
# 4. delete all files in list
# 5. delete empty links
# 5. delete empty files and dirs
# TODO 6. find dupes left in $1 and make them hardlinked

### script to tune flags

### fdupes [ options ] DIRECTORY ...
# -r --recurse
# -n --noempty			# exclude zero-length files from consideration
# -o --order=WORD		# WORD == name (default) | mtime
# -O --paramorder		#! jdupes: parameter order preservation is more important
                    # than  the  chosen sort;
										## -O dir1 dir3 dir2 will always 
										## place 'dir1' results first in any match  set  (where relevant) 
# -N --noprompt			# preserve the first file in each set of duplicates and 
										# delete the others  without  prompting the user
# -f --omitfirst    # omit the first file in each set of matches
# -S --size					# show size of duplicate files
# -m --summarize		# summarize duplicate files information
# -L --linkhard			# replace all duplicate files with hardlinks to the 
#										# first file  in each set of duplicates


###!!! it must be grepped by $1 (not $2) to preserve files in $1!!!
### so rename $2 if it needs to
fdupes --recurse --noempty --order=name "${1}" "${2}" | \
	grep --invert-match "${1}" | grep . | \
	xargs --delimiter='\n' rm --

### OR:
#jdupes --recurse --noempty --order=name --paramorder --omitfirst "${1}" "${2}" | \
#	grep --invert-match "${1}" | grep . | \
#	xargs --delimiter='\n' rm --

### delete symlinks 
find "${2}" -type l -delete 

### delete empty dirs
#find "${2}" -type d -empty -delete
### also delete empty files
find "${2}" -type f -empty -delete -o -type d -empty -delete 
### OR in case of busybox: 
#find "${2}" -type d -depth -exec rmdir -p --ignore-fail-on-non-empty {} \;
## OR:
#shopt -s globstar
#for dir in "${2}"/**/; do
#   files=("$dir"/*)
#   [[ ${files[@]} ]] || rmdir -v "$dir"
#done

### make hardlinks
#jdupes --recurse --noempty --linkhard "${1}"

