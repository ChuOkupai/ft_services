#!/bin/bash

clean_all()
{
	print_step 'Removing existing components'

	echo -e 'Cleaning '$COLOR_LCYAN'minikube'$COLOR_RESET'...'
	if minikube status > $NULL 2>&1; then
		minikube stop
	fi
	minikube delete
	rm -rf ~/.kube ~/.minikube

	echo -e "Cleaning$COLOR_LCYAN kubectl$COLOR_RESET..."
	kubectl delete all --all 2> $NULL

	local l=$(docker ps -a -q 2> $NULL)
	if [ ! -z "$l" ]; then
		docker rm -vf $l > $NULL 2>&1
	fi
	local l=$(docker images -a -q 2> $NULL)
	if [ ! -z "$l" ]; then
		echo -e "Cleaning$COLOR_LCYAN docker$COLOR_RESET..."
		docker rmi -f $l > $NULL 2>&1
	fi
	rm -f $PATH_LOG
}

clean_kubectl()
{
	print_step 'Cleaning kubectl'
	kubectl delete all --all -n metallb-system
	kubectl delete configmap --all -n metallb-system
	kubectl delete secret --all -n metallb-system
	kubectl delete deployments --all
	kubectl delete svc --all
	kubectl delete pvc --all
	rm -f $PATH_LOG
}
