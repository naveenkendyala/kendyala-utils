#/bin/bash
while true
do
{

 #Provide the Metrics for the Horizontal Pod Autoscalar
 #echo ""
 #echo ""
 #kubectl get hpa

 #Fix for the Kubectl top pod command & sort on memory
 echo Metrics Refresh Every $1 seconds............
 echo ""
 echo "####################################################################"
 echo "POD NAME	 			         CPU   MEMORY             "
 echo "####################################################################"
 oc adm top po --no-headers | sort --reverse --key 3 --numeric | head -100

 #Sleep for the dashboard to display
 sleep $1;

 #Clear
 clear;
}
done;
