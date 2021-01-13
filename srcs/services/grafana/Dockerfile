FROM alpine-telegraf

# INIT
ENV FT_SERVICES_LIST="$FT_SERVICES_LIST grafana-server"
ENV INFLUX_DATABASE='grafana'
RUN apk add --no-cache grafana

# GRAFANA SETUP
ARG GRAFANA_PATH='/usr/share/grafana'
ARG GRAFANA_PROV_PATH="$GRAFANA_PATH/conf/provisioning"
WORKDIR $GRAFANA_PATH
RUN rm $GRAFANA_PROV_PATH/dashboards/sample.yaml $GRAFANA_PROV_PATH/datasources/sample.yaml
COPY config/dashboard.json $GRAFANA_PROV_PATH/dashboards
COPY config/dashboard.yaml $GRAFANA_PROV_PATH/dashboards
COPY config/datasources.yaml $GRAFANA_PROV_PATH/datasources

# EXEC
EXPOSE 3000
CMD (grafana-server web &); telegraf
