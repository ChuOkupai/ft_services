FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST influxd"
ENV INFLUX_DATABASE='influxdb'
ENV INFLUX_HOST='localhost'
COPY config/start.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start.sh
RUN apk add --no-cache influxdb

# INFLUXDB SETUP
RUN rm -f /etc/influxdb.conf
COPY config/influxdb.conf /etc/influxdb

# EXEC
EXPOSE 8086
CMD start.sh
