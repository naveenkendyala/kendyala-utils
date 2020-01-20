
#Clean up the whole docker
docker prune system -af         #a=all;f=forced

#Remove All Tags of a Specific unwanted images 
docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi

