#Provision in gcp or k8s
kubectl create ns quarkus-demo
kubectl config set-context --current --namespace quarkus-demo
kubectl apply -f 01.gcp


#Provision on ocp


