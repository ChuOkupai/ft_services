#!/bin/bash

# Assert that all dependencies exists
assert_dependencies()
{
	for i in "$@"; do
		if ! command -v $i > $NULL; then
			echo -e $COLOR_LRED"fatal error: $i - dependency not found."$COLOR_RESET >&2
			echo >&2
			echo 'Please install all dependencies before using this script.' >&2
			exit 2
		fi
	done
}

print_step()
{
	echo -e "$COLOR_LBLUE* $1$COLOR_RESET"
}
