#!/bin/sh

# Checks if all services stored in $FT_SERVICES_LIST are running
readonly list=$(ps -o stat,args | awk 'NR > 1 && $1 != "Z" { print $2 }')
for i in $FT_SERVICES_LIST; do
	if ! echo "$list" | grep -q "$i"; then
		echo "$i is not running" >&2
		exit 2
	fi
done
