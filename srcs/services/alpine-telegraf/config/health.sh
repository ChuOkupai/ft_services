#!/bin/sh

# Checks if all services stored in $FT_SERVICES_LIST are running
for i in $FT_SERVICES_LIST; do
	if ! pidof "$i" > /dev/null; then
		echo "$i is not running" >&2
		exit 2
	fi
done
