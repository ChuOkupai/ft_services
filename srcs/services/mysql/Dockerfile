FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST mysqld"
ENV INFLUX_DATABASE='mysql'
COPY config/start.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start.sh
RUN apk add --no-cache gettext mysql mysql-client

# MYSQL SETUP
ENV MYSQL_USERNAME='wordpress'
ENV MYSQL_PASSWORD='wordpress'
COPY config/my.cnf /etc
COPY config/init.sql /tmp
RUN envsubst < /tmp/init.sql > /etc/mysql/init.sql
RUN mkdir -p /run/mysqld

# CLEAN
RUN apk del --no-cache gettext

# EXEC
EXPOSE 3306
CMD start.sh
