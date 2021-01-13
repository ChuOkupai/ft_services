#!/bin/bash

init()
{
	local -r CPU_CORES=`grep -c ^processor /proc/cpuinfo`

	print_step 'Initialization'
	sudo groupadd docker 2> $NULL
	sudo usermod -aG docker $USER
	sudo service docker restart
	sudo chown $USER /var/run/docker.sock
	minikube config set WantUpdateNotification false
	minikube start --cpus="$CPU_CORES" --driver=docker --memory=2048
	sudo chown -R $USER ~/.kube ~/.minikube
}
