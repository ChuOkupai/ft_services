#!/bin/bash

readonly BACKUP_EXT='.bak'
readonly COLOR_LRED='\033[91m'
readonly COLOR_LBLUE='\033[94m'
readonly COLOR_LCYAN='\033[96m'
readonly COLOR_RESET='\033[39m'
readonly NULL='/dev/null'
readonly PATH_LOG='logins.txt'

for i in srcs/scripts/*; do
	source $i
done

assert_dependencies docker kubectl minikube

if [ "$1" = "clean" ]; then
	clean_all
elif [ "$1" = "rebuild" ]; then
	clean_kubectl
	build
elif [ "$#" -eq 0 ]; then
	clean_all
	init
	build
else
	echo "Usage: $0 [OPTION]"
	echo 'ft_services install script by Adrien Soursou.'
	echo
	echo 'Without option, this script initializes minikube, builds all services and deploys them.'
	echo "Warning: this script was designed to work inside the 42's VM only!"
	echo
	echo 'Options list:'
	echo '  clean    Remove all components and exit'
	echo '  rebuild  Build the project without initializing minikube'
	exit 1
fi
