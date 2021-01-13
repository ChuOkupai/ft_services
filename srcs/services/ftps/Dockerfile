FROM alpine-telegraf

# USER DEFINED CONSTANTS
ARG FTPS_USERNAME='user'
ARG FTPS_PASSWORD='user'

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST vsftpd"
ENV INFLUX_DATABASE='ftps'
RUN apk add --no-cache openssl vsftpd

# FTPS SETUP
ARG IP="localhost"
ENV FTPS_IP="$IP"
COPY config/vsftpd.conf /etc/vsftpd
RUN adduser -D $FTPS_USERNAME
RUN echo "$FTPS_USERNAME:$FTPS_PASSWORD" | chpasswd
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42' \
	-keyout /etc/ssl/private/vsftpd.pem \
	-out /etc/ssl/certs/vsftpd.crt

# EXEC
EXPOSE 21 21000
CMD (vsftpd -opasv_address="$FTPS_IP" /etc/vsftpd/vsftpd.conf &); telegraf
