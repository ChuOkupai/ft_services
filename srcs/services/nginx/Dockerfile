FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST nginx sshd"
ENV INFLUX_DATABASE='nginx'
RUN apk add --no-cache nginx openssh openssl

# NGINX SETUP
ARG NGINX_USERNAME='www'
ARG NGINX_PASSWORD='www'
COPY config/nginx.conf /etc/nginx
COPY config/ft_services /var/www/ft_services
RUN adduser -D $NGINX_USERNAME -g www-data
RUN echo "$NGINX_USERNAME:$NGINX_PASSWORD" | chpasswd
RUN chown -R "$NGINX_USERNAME:www-data" /var/www
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42' \
	-keyout /etc/ssl/private/nginx.pem \
	-out /etc/ssl/certs/nginx.crt
RUN mkdir -p /run/nginx

# SSH SETUP
COPY config/motd /etc/motd
RUN ssh-keygen -A

# CLEAN
RUN apk del --no-cache openssl

# EXEC
EXPOSE 22 80 443
CMD nginx; (/usr/sbin/sshd &); telegraf
