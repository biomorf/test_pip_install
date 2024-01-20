#!/bin/bash
### 

### TODO only names WITHOUT WHITESPACES!!!

echo -e  "!!!This is test of home dir backup!!!\n"

src_dir_prefix="$HOME"
#src_array=("
#	BASh/ 
#	linadm/
#	white space/
#	")
src_array="$(cat "${HOME}/.local/bin/backup_ph.list")"
dest="gm:/programming/snippets/"

# TODO fix whitespaces in a elements of array
for dir in ${src_array[@]}; do
#	echo -e "${src_dir_prefix}/""$dir" "$dest \n"
	rclone_copyto.sh "${src_dir_prefix}/$dir" "$dest"
done

