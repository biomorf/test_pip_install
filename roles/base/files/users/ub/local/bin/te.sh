#!/bin/sh
###

CURDATE="$(date +%Y-%m-%d)"

remote_host='gm:'
src_default="${remote_host}/tmp/rclone"
src_input="${1}"
src="${src_input:-$src_default}"

dest_default="$HOME/tmp/rclone"
dest_input="${2}"
dest="${dest_input:-"$dest_default"}"
backup_basename="$(basename "${dest}")"'_backup'"${CURDATE}"
backup_dir="$(dirname "${dest}")"'/'"${backup_basename}"

echo $src $dest $backup_dir


