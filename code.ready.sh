#Delete the Existing CRC
crc delete

#Change the cpus & memory numbers desired value. The value is in MB
crc config set cpus 6
crc config set memory 10240

#Apply the setting
crc setup

#Start the CRC with the pull secret
crc start -p <path_to_pull_secret>

#OCP < 4.3 :: Enable the metrics and alerting
oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring

#OCP > 4.3 :: #Enable the metrics and alerting
oc get clusterversion version -ojsonpath='{range.spec.overrides[*]}{.name}{"\n"}{end}' | nl -v 0
oc patch clusterversion/version --type='json' -p '[{"op":"remove", "path":"/spec/overrides/<unmanaged-operator-index>"}]' -oyaml

#Get the node consumption
oc describe nodes | grep -i Allocated -A 1000 | grep -i Events -B 1000


#Other Commands
oc new-project sidebyside
oc apply -f /Users/naveenkumarkendyala/00.professional/01.workspaces/2019.09.eclipse/sidebyside-springboot/deployment/gke-deployment.yaml
oc expose deployment.apps/springboot-hello-deploy
oc expose service/springboot-hello-deploy
oc autoscale deploy/springboot-hello-deploy --min 1 --max 5 --cpu-percent=40
oc get hpa