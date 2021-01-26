#!/bin/sh

while [ ! -d '/mnt/influxdb' ]; do
	sleep 1
done
influxd -config /etc/influxdb.conf &
readonly query="CREATE USER $INFLUX_USERNAME WITH PASSWORD '$INFLUX_PASSWORD' WITH ALL PRIVILEGES"
env -i influx -execute "$query"
telegraf
