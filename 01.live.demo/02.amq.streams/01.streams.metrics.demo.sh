The simplest way to set up is to perform these steps in "myproject" namespace

oc project myproject 

# Install AMQ Streams Operator from operator hub
# Install prometheus operator from operator hub

#download and unzip https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=79741

cd amq-streams-1.4.0-ocp-install-examples/examples/metrics

#Create a Kafka custom resource in the AMQ Streams operator using the contents of the file kakfka-metrics.yaml, make sure you adjust the persistent volume sizes to be smaller (the default is 100 GB)

#Create prometheus (If using a different project than "myproject", update the following files to replace "myproject" with the correct project name)

oc create secret generic additional-scrape-configs --from-file=prometheus-additional-properties/prometheus-additional.yaml
oc apply -f prometheus-install/strimzi-service-monitor.yaml
oc apply -f prometheus-install/prometheus-rules.yaml
oc apply -f prometheus-install/prometheus.yaml


#Install grafana dashboard

oc apply -f grafana-install/grafana.yaml
oc expose svc grafana

#login to the grafana dashboard using the route creatd (admin/admin).

#Create a prometheus datasource using http://prometheus-operated:9090, Test and Save.

#On the top left, hover on the "+" icon, and select "Import" and import the following files, one at a time

grafana-dashboards/strimzi-kafka-exporter.json
grafana-dashboards/strimzi-kafka.json
grafana-dashboards/strimzi-zookeeper.json

#select prometheus as the source when prompted.


# The Strimzi kafka exporter dashboard will not who any metrics until you create a producer and a consumer

git clone git clone https://github.com/gpe-mw-training/amq-streams-foundations-labs

cd amq-streams-foundations-labs/01_deploy_and_connect

oc apply -f strimzi-producer.yaml

oc apply -f strimzi-consumer.yaml