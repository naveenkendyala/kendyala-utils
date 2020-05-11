#Provision OCP Environment

#Create new OCP Project
oc new-project myproject

#Install the Streams Operator

#Install the Kafka Cluster with "listener" configuration to external type as "route"
oc apply -f amq.streams.1.4.1/examples/kafka/00.custom.kafka-persistent.01.yaml

#Create a Topic
oc apply -f amq.streams.1.4.1/examples/topic/00.custom.kafka.topic.01.yaml

#Get the routes
oc get routes my-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'

#Get the ca cert and imnport into trusted certs
oc extract secret/my-cluster-cluster-ca-cert --keys=ca.crt --to=- > ca.crt
keytool -import -trustcacerts -alias root -file ca.crt -keystore truststore.jks -storepass password -noprompt

#Send a Message to Topic
#***** CHANGE THE BROKER LIST *****
kafka_2.12-2.4.0.redhat-00005/bin/kafka-console-producer.sh \
--broker-list my-cluster-kafka-bootstrap-amq-streams-pg.apps.cluster-91fc.91fc.example.opentlc.com:443 \
--producer-property security.protocol=SSL \
--producer-property ssl.truststore.password=password \
--producer-property ssl.truststore.location=truststore.jks \
--topic my-topic

#Receive a Message
#***** CHANGE THE BOOTStRAP LIST *****
kafka_2.12-2.4.0.redhat-00005/bin/kafka-console-consumer.sh \
--bootstrap-server my-cluster-kafka-bootstrap-amq-streams-pg.apps.cluster-91fc.91fc.example.opentlc.com:443 \
--consumer-property security.protocol=SSL \
--consumer-property ssl.truststore.password=password \
--consumer-property ssl.truststore.location=truststore.jks \
--topic my-topic --from-beginning