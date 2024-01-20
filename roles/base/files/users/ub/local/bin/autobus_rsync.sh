#!/bin/sh


###rclone mount --daemon rdrive-maslennikov2012: ~/share/google/rclone-gdrive-maslennikov2012/
# google-drive-ocamlfuse -label maslennikov2012 ~/share/google/myGoogleDrive-maslennikov2012/

### incremental backup
CURDATE="$(date +%Y-%m-%d)"
#src="${1}"
#src="/home/ub/share/google/rclone-gdrive-maslennikov2012/Autobus/"
#src="/home/ub/share/google/myGoogleDrive-maslennikov2012/Autobus/"
src="/home/ub/share/local/rclone-gdrive-maslennikov2012/Autobus/"
#dest="${2}"
dest="/home/ub/share/local/autobus/Autobus/"
backup_dir="${dest}../backup_inc/${CURDATE}"

#export $CURDATE

mkdir --verbose --parents "${backup_dir}" 
rsync --progress -avb --delete --backup-dir="${backup_dir}" "${src}" "${dest}"


### log out
###fusermount -u ~/share/google/rclone-gdrive-maslennikov2012/
#fusermount -u ~/share/google/myGoogleDrive-maslennikov2012/

