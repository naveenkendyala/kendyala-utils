####################################################################################
################################INSTALL GOOGLE CLOUD GKE ###########################
####################################################################################

#01 : Check Python Version (2.7)
#python -V

#02 : Download gcloud sdk

#03 : Install the SDK
#./google-cloud-sdk/install.sh

#04 : Initialize the environment
#gcloud init 

#05 : Create GKE cluster

#06 : Access Cluster
#    Use the Connect Cluster Command from the Google Console

#07 : Enable Dashboard 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

#08 : Create Role
#    Apply the dashboard-sa.yaml
kubectl apply -f /Users/naveenkumarkendyala/00.professional/01.workspaces/2020.git.repos/kendyala-utils/00.provision.cluster.gke/02.dashboard-sa.yaml

#09 : Create ROLE BINDING
#    Apply the dashboard-rolebinding.yaml
kubectl apply -f /Users/naveenkumarkendyala/00.professional/01.workspaces/2020.git.repos/kendyala-utils/00.provision.cluster.gke/03.dashboard-rolebinding.yaml

#10 : Get the Token
#kubectl proxy
#kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')


#11 : Access the Cluster
#http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

#12 : Deploy the Services

#13 : Enable Firewall to allow traffic
#gcloud compute firewall-rules create <insert_rule_name> --allow tcp:[NODE_PORT]
#gcloud compute firewall-rules create allow-mysql --allow tcp:30100

#gcloud compute firewall-rules create allow-eap-jvm --allow tcp:30200
#gcloud compute firewall-rules create allow-spring-jvm --allow tcp:30201
#gcloud compute firewall-rules create allow-quarkus-native --allow tcp:30203
#gcloud compute firewall-rules create allow-quarkus-jvm --allow tcp:30202


#gcloud compute firewall-rules delete allow-mysql
#gcloud compute firewall-rules delete allow-quarkus-jvm
#gcloud compute firewall-rules delete allow-quarkus-native
#gcloud compute firewall-rules delete allow-spring-jvm
#gcloud compute firewall-rules delete allow-eap-jvm
