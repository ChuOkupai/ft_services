#!/bin/bash

# call: dockerfile variable_name
get_arg()
{
	cat $1 | grep "^ARG $2=" | cut -d '=' -f 2
}

write_log()
{
	echo '+--------------------------------------------------------------+' > $PATH_LOG
	echo "ft_services index:" >> $PATH_LOG
	echo "  url: http://$IP_MINIKUBE" >> $PATH_LOG
	local -r path='srcs/services/ftps/Dockerfile'
	local -r user=$(get_arg $path FTPS_USERNAME)
	local -r pass=$(get_arg $path FTPS_PASSWORD)
	echo "FTPS:" >> $PATH_LOG
	echo "  username: $user" >> $PATH_LOG
	echo "  password: $pass" >> $PATH_LOG
	echo "Grafana:" >> $PATH_LOG
	echo "  username: admin" >> $PATH_LOG
	echo "  password: admin" >> $PATH_LOG
	local -r path='srcs/services/nginx/Dockerfile'
	local -r user=$(get_arg $path NGINX_USERNAME)
	local -r pass=$(get_arg $path NGINX_PASSWORD)
	echo "SSH:" >> $PATH_LOG
	echo "  command: ssh $user@$IP_MINIKUBE" >> $PATH_LOG
	echo "  password: $pass" >> $PATH_LOG
	echo "Wordpress:" >> $PATH_LOG
	echo "  username: admin" >> $PATH_LOG
	echo "  password: admin" >> $PATH_LOG
	echo '+--------------------------------------------------------------+' >> $PATH_LOG
}

build()
{
	if ! minikube status > $NULL 2>&1; then
		echo -e $COLOR_LRED'fatal error: minikube is not running'$COLOR_RESET >&2
		exit 2
	fi
	export IP_MINIKUBE=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | tail -n 1)
	local -r METALLB_URL='https://raw.githubusercontent.com/metallb/metallb/v0.9.5'
	local -r CONFIG_PATH='srcs/deployments/config.yaml'
	local -r BACKUP_CONFIG_PATH="$CONFIG_PATH$BACKUP_EXT"

	print_step 'Build'
	minikube addons enable dashboard
	minikube addons enable metrics-server
	eval $(minikube docker-env)
	for i in $(echo srcs/services/* | sort); do
		name=$(basename $i)
		echo -e "* ft_services $COLOR_LBLUE- build step - $COLOR_LCYAN$name$COLOR_RESET"
		docker build -t $name $i --build-arg IP="$IP_MINIKUBE"
	done

	print_step 'Deployment'
	kubectl apply -f $METALLB_URL/manifests/namespace.yaml
	kubectl apply -f $METALLB_URL/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="`openssl rand -base64 128`"
	mv $CONFIG_PATH $BACKUP_CONFIG_PATH
	envsubst '$IP_MINIKUBE' < $BACKUP_CONFIG_PATH > $CONFIG_PATH
	kubectl apply -f srcs/deployments
	mv $BACKUP_CONFIG_PATH $CONFIG_PATH
	eval $(minikube docker-env -u)

	write_log
	cat $PATH_LOG
	minikube dashboard
}
