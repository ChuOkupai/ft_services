FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST nginx php-fpm7"
ENV INFLUX_DATABASE='wordpress'
COPY config/start.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start.sh
RUN apk add --no-cache gettext mysql-client nginx php7 php7-fpm php7-xml php7-xmlreader php7-curl php7-exif php7-ftp php7-gd php7-iconv php7-json php7-mbstring php7-mysqli php7-openssl php7-posix php7-sockets php7-tokenizer php7-zlib

# WORDPRESS SETUP
ENV MYSQL_HOST="mysql"
ARG IP='localhost'
ENV WORDPRESS_HOST="$IP"
COPY config/init.sql /etc/mysql/init-template.sql
RUN touch /etc/mysql/init.sql
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip
RUN unzip -d /var/www /tmp/wordpress.zip
COPY config/wp-content /tmp/wp-content
RUN cp -r /tmp/wp-content /var/www/wordpress
COPY config/wp-config.php /var/www/wordpress

# NGINX SETUP
COPY config/nginx.conf /etc/nginx
RUN adduser -D www -g www-data
RUN chown -R "www:www-data" /var/www
RUN mkdir -p /run/nginx

# PHP SETUP
COPY config/www.conf /etc/php7/php-fpm.d

# EXEC
EXPOSE 5050
CMD start.sh
