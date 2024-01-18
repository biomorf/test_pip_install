#!/bin/sh
###

###!!! it must be grepped by $1 (not $2) to preserve files in $1!!!
### so rename $2 if it needs to
fdupes --recurse --noempty --order=name "${1}" "${2}" | \
	grep --invert-match "${1}" | grep . 

