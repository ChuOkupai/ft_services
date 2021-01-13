FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST nginx php-fpm7"
ENV INFLUX_DATABASE='phpmyadmin'
COPY config/start.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start.sh
RUN apk add --no-cache mysql-client nginx php7-fpm phpmyadmin

# NGINX SETUP
COPY config/nginx.conf /etc/nginx
RUN adduser -D www -g www-data
RUN chown -R "www:www-data" /var/www
RUN mkdir -p /run/nginx

# PHP SETUP
COPY config/www.conf /etc/php7/php-fpm.d

# PHPMYADMIN SETUP
ENV MYSQL_HOST="mysql"
COPY config/config.inc.php /etc/phpmyadmin
COPY config/init.sql /etc/mysql/init.sql
RUN ln -s /usr/share/webapps/phpmyadmin /var/www/phpmyadmin
RUN mkdir -p /usr/share/webapps/phpmyadmin/tmp
RUN chown -R "www:www-data" /var/www/phpmyadmin /usr/share/webapps/phpmyadmin

# EXEC
EXPOSE 5000
CMD start.sh
