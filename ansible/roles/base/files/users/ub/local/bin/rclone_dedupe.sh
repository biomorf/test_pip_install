#!/bin/sh
###

target="gm:/tmp/rclone/"
mode="newest"

###
### rclone dedupe [ interactive|skip|first|newest|oldest|largest|smallest|rename ] remote:path [--by-hash]


rclone dedupe ${mode} \
	${target} --by-hash

