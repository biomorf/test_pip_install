#!/bin/sh
###

### default sync '~/prog/' dir to remote gm:

CURDATE="$(date +%Y-%m-%d)"

src_default="$HOME/tmp/rclone"
src_input="${1}"
src="${src_input:-$src_default}"

remote_host='gm:'
dest_default="${remote_host}/tmp/rclone"
dest_input="${2}"
dest="${dest_input:-$dest_default}"

backup_basename="$(basename "${dest}")"'_backup'"${CURDATE}"
backup_dir="$(dirname "${dest}")"'/'"${backup_basename}"

##echo -e  $src \\n $dest \\n $backup_dir \\n

if [ ! -d "${backup_dir}" ]; then
	rclone mkdir --verbose "${backup_dir}"
fi

### COPY | SYNC copyes only content of dir to dir

# copy to remote with backup
#rclone copyto --verbose --progress --update --log-file "$0".log --drive-skip-shortcuts --backup-dir="${backup_dir}" \
#  "${src}" "${dest}"

### TODO so use COPYTO instead!
# ? --refresh-times | --no-update-modtime
# ? --compare-dest stringArray
# ? --exclude-if-present string
# ? -f, --filter stringArray
### as it copies single file to single file too
#rclone copyto --verbose --progress --update --log-file "$0".log --drive-skip-shortcuts --backup-dir="${backup_dir}" \
#  "${src}" "${dest}"

### !!! NO COPY of file to dir !!!!!
###!!!! if file on DEST is newer than on SRC, then it would NOT be overwritten !!!!


### SAME with MOVE/MOVETO
rclone moveto --verbose --progress --update --log-file "$0".log --drive-skip-shortcuts --backup-dir="${backup_dir}" \
	--delete-empty-src-dirs \
  "${src}" "${dest}"


###  rclone sync
rclone sync --verbose --progress --log-file "$0".log --drive-skip-shortcuts --backup-dir="${backup_dir}" \
	--create-empty-src-dirs \
	"${src}" "${dest}"

###  rclone bisync
#!! currently BETA - do COPY, clean up (dedupe???) then SYNC instead for a while 
#rclone bisync --verbose --progress --update --log-file "$0".log --drive-skip-shortcuts --backup-dir="${backup_dir}" \
#	--remove-empty-dirs \
#  "${dest}" "${src}" 

