#Pre-Requisite
#01# Download and unzip From Source https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=79741
#02# amq-streams-1.4.1-ocp-install-examples/examples/metrics/kakfka-metrics.yaml :: adjust pv sizes to be smaller (the default is 100 GB)
#03# If you are going to use "myproject", you can skip the below. Otherwise update the project name in the below files
#### Change Prometheus:: amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-additional-properties/prometheus-additional.yaml
#### Change Prometheus:: amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/strimzi-service-monitor.yaml
#### Change Prometheus:: amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/prometheus-rules.yaml
#### Change Prometheus:: amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/prometheus.yaml
#04# git clone git clone https://github.com/gpe-mw-training/amq-streams-foundations-labs

#Create New Project
oc new-project myproject

# Install AMQ Streams Operator from operator hub
# Install prometheus operator from operator hub

#Create the cluster with [ZooKeeper, Kafka, Kafka Exporter, Entity Operator, Prometheus Metrics]
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/metrics/kafka-metrics.yaml

###Prometheus
#
oc create secret generic additional-scrape-configs --from-file=amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-additional-properties/prometheus-additional.yaml
#
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/strimzi-service-monitor.yaml
#
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/prometheus-rules.yaml
#
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/metrics/prometheus-install/prometheus.yaml


#Install grafana dashboard
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/metrics/grafana-install/grafana.yaml
oc expose svc grafana

#Configure Grafana
#Login to the grafana dashboard using the route creatd (admin/admin)
#Check the Route on the Developer Console
#Create a prometheus datasource using http://prometheus-operated:9090, Test and Save.

#On the top left, hover on the "+" icon, and select "Import" and import the following files, one at a time
#select prometheus as the source when prompted.
grafana-dashboards/strimzi-kafka-exporter.json
grafana-dashboards/strimzi-kafka.json
grafana-dashboards/strimzi-zookeeper.json

#Create a topic
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/topic/00.custom.kafka.topic.01.yaml


# The Strimzi kafka exporter dashboard will not who any metrics until you create a producer and a consumer
# Run the producer and Consumer from the "amq-streams-foundations-labs"
oc apply -f amq-streams-foundations-labs/01_deploy_and_connect/strimzi-producer.yaml
oc apply -f amq-streams-foundations-labs/01_deploy_and_connect/strimzi-consumer.yaml