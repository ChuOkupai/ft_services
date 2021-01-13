#!/bin/sh

readonly DB_NAME='wordpress'
readonly MYSQL_CONNECT="mysql -u wordpress -pwordpress"
while true; do
	error=$($MYSQL_CONNECT $DB_NAME < /dev/null 2>&1)
	if [ $? -eq 0 ]; then
		break
	elif echo $error | grep 1049 > /dev/null; then
		while ! $MYSQL_CONNECT -e "CREATE DATABASE $DB_NAME"; do
			sleep 1
		done
		envsubst '$WORDPRESS_HOST' < /etc/mysql/init-template.sql > /etc/mysql/init.sql
		while ! $MYSQL_CONNECT $DB_NAME < /etc/mysql/init.sql; do
			sleep 1
		done
		break
	fi
	sleep 1
done

php-fpm7
nginx
telegraf
