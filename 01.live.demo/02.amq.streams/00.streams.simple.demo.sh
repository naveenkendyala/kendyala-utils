#Provision OCP Environment

#Create new OCP Project
oc new-project myproject

#Install the Streams Operator

#Install the Kafka Cluster with "listener" configuration to external type as "route"
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/kafka/00.custom.kafka-persistent.01.yaml

#Create a Topic
oc apply -f amq-streams-1.4.1-ocp-install-examples/examples/topic/00.custom.kafka.topic.01.yaml

#Get the routes
#***** KEEP THIS VALUE TO BE USED IN THE PRODUCER AND CONSUMER CONFIG *****
oc get routes my-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'

#Get the ca cert and imnport into trusted certs
oc extract secret/my-cluster-cluster-ca-cert --keys=ca.crt --to=- > ca.crt
keytool -import -trustcacerts -alias root -file ca.crt -keystore truststore.jks -storepass password -noprompt

#Send a Message to Topic
#***** CHANGE THE BROKER LIST *****
$STREAMS_HOME/bin/kafka-console-producer.sh \
--broker-list my-cluster-kafka-bootstrap-myproject.apps.cluster-91fc.91fc.example.opentlc.com:443 \
--producer-property security.protocol=SSL \
--producer-property ssl.truststore.password=password \
--producer-property ssl.truststore.location=truststore.jks \
--topic my-topic

#Ensure that the STREAMS_HOME is set to the directory of the streams in the env variables
#export STREAMS_HOME=/Users/naveenkumarkendyala/Applications/redhat/amq-streams/kafka_2.12-2.4.0.redhat-00005

#Receive a Message
#***** CHANGE THE BOOTStRAP LIST *****
$STREAMS_HOME/bin/kafka-console-consumer.sh \
--bootstrap-server my-cluster-kafka-bootstrap-myproject.apps.cluster-91fc.91fc.example.opentlc.com:443 \
--consumer-property security.protocol=SSL \
--consumer-property ssl.truststore.password=password \
--consumer-property ssl.truststore.location=truststore.jks \
--topic my-topic --from-beginning