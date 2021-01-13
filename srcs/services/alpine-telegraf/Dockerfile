FROM alpine
LABEL maintainer='Adrien Soursou <asoursou@student.42.fr>'

# USER DEFINED CONSTANTS
ENV INFLUX_USERNAME='root'
ENV INFLUX_PASSWORD='root'
ENV INFLUX_HOST='influxdb'

# INIT
ENV FT_SERVICES_LIST='telegraf'
COPY config/health.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/health.sh
RUN sed -i /etc/apk/repositories -e 's|/v.*/|/edge/|g'
RUN apk add --no-cache bash telegraf
RUN mkdir -p /etc/default

# TELEGRAF SETUP
RUN mkdir -p /etc/telegraf
COPY config/telegraf.conf /etc/telegraf

# EXEC
CMD telegraf
