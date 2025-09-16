# we need to have a volume mapping the var/run/docker.sock to 
# the sub containers to have access to the host docker deamon

docker run -it -v /var/run/docker.sock:/var/run/docker.sock ubuntu /bin/bash

# run the comman d
ls /var/run

apt update && apt install curl --yes

# acceds via API rest
curl --unix-socket /var/run/docker.sock http://localhost/version

#1 pull the image
curl --unix-socket /var/run/docker.sock -X POST  -H "Content-Type: application/json" http://localhost/images/create?fromImage=nginx:latest

#2 Create container, but it is not running

curl --unix-socket /var/run/docker.sock -X POST -d '{"Image":"nginx", "HostConfig":{ "PortBindings":{"80/tcp":[{"HostIp":"0.0.0.0.","HostPort":"8080"}]}}}' -H "Content-Type: application/json" http://localhost/containers/create

#3 start 
curl --unix-socket /var/run/docker.sock -X POST  -H "Content-Type: application/json" http://localhost/containers/fe76565a1877e9e1fe660bbf0d5fd432a4cef61d708f21718a2eaed520f2f5dd/start

 # 4 list
apt update && sudo apt install jq

curl --unix-socket /var/run/docker.sock -X GET http://localhost/containers/json?all=true  | jq .


# CONTAINER DOES NOT HAVE SUDO. IT RUNS THE ROOT USER ALREADY


docker container run -d --name dind-test --privileged docker:dind

ps -ef --forest

docker exec -it dind-test /bin/bash