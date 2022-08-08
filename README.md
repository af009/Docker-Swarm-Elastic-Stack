# Docker-Swarm-Elastic-Stack


#  Setting up a Docker Swarm Cluster
###  5 instances recommended - (3 Master and 2 Workers)


## **1- Install Docker in all the instances**
```
 bash <(curl -s https://gitlab.com/-/snippets/2353002/raw/main/install-docker.sh)
 ```
## **2- Run in the Master instance**
```
docker swarm init --advertise-addr <private ip>
```
Paste the output into the worker instances

### if you  want to add more master nodes to the cluster, run:

`docker swarm join-token master` Paste the output to the candidate instance

#  Setting up the Elastic Stack

## Change the env variables to your node names, elastic password, etc.


## **1- Run in all the nodes**
```shell
sudo sysctl -w vm.max_map_count=262144 # increase virtual memory  
sudo echo 'vm.max_map_count=262144' >> /etc/sysctl.conf #(persist reboots)
```

## **2- Run the deployment script  in the master node**
### Make sure to change the Env variables before
```
./deployStack.sh
```
### The script create a network (overlay) over the cluster to allow the services communicate. After then install the services.


## **3- Check the deployment (wait 1-2 minutes)**
```shell
docker service ls # show the services running
docker stack ps --no-trunc elastic # check for errors

```
## **4- Finally, login and check the communication between Logstash and Elasticsearch**

### For login in the browser: master-node.ip , username: elastic, password: 'your password'

### Test communication: Send messages over the tcp protocol (run in one of the nodes)
```shell
telnet localhost 5000
# write something
```

### In the browser go the dev console and run:
```shell
GET hello-logstash-docker/_search
{
  "query": {
    "match_all": {}
  }
}

```
### You will see the messages in the right screen.
