#/bin/bash
while true
do
{
 #Provide the Metrics for the Horizontal Pod Autoscalar
 #echo ""
 #echo ""
 #kubectl get hpa

 #Fiox for the Kubectl top pod command & sort on memory
 echo ""
 echo "####################################################################"
 echo "POD NAME	 			         CPU   MEMORY             "
 echo "####################################################################"
 kubectl top po --no-headers | sort --reverse --key 3 --numeric | head -100

 #Sleep for the dashboard to display
 sleep 10;

 #Clear
 clear;
}
done;
