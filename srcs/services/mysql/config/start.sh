#!/bin/sh

while [ ! -d '/mnt/mysql' ]; do
	sleep 1
done
if [ ! -d '/mnt/mysql/mysql' ]; then
	mysql_install_db --user=root --datadir='/mnt/mysql'
	mysqld --user=root --skip-networking=0 --init_file=/etc/mysql/init.sql &
else
	mysqld --user=root --skip-networking=0 &
fi
telegraf
