

ls /var/run

# unix socket which makes the integrarion with docker deamon

docker.sock 

# command cli

docker version


curl --unix-socket /var/run/docker.sock http://localhost/version

#installing jq
sudo apt update
sudo apt install jq

# jq package to format the output in json 
curl --unix-socket /var/run/docker.sock http://localhost/version | jq .

# get info
curl --unix-socket /var/run/docker.sock http://localhost/info | jq .

# version
curl --unix-socket /var/run/docker.sock http://localhost/v1.30/info | jq .

# create container

#1 pull the image
curl --unix-socket /var/run/docker.sock -X POST  -H "Content-Type: application/json" http://localhost/images/create?fromImage=nginx:latest

#2 Create container, but it is not running
curl --unix-socket /var/run/docker.sock -X POST -d '{"Image":"nginx"}' -H "Content-Type: application/json" http://localhost/containers/create

#Binding Port
curl --unix-socket /var/run/docker.sock -X POST -d '{"Image":"nginx", "HostConfig":{ "PortBindings":{"80/tcp":[{"HostIp":"0.0.0.0.","HostPort":"8080"}]}}}' -H "Content-Type: application/json" http://localhost/containers/create

#config file as parameter
curl --unix-socket /var/run/docker.sock -X POST -d @hostConfig.json -H "Content-Type: application/json" http://localhost/containers/create

#3 start 
curl --unix-socket /var/run/docker.sock -X POST  -H "Content-Type: application/json" http://localhost/containers/f9b1450ce78c/start


# the command docker run -d nginx does the 3 steps automatically. 
# via api we have to do it manually.

# listing the container

curl --unix-socket /var/run/docker.sock -X GET http://localhost/containers/json

## get alll

curl --unix-socket /var/run/docker.sock -X GET http://localhost/containers/json?all=true | jq .


# delete


# 1 stop
curl --unix-socket /var/run/docker.sock -X POST  -H "Content-Type: application/json" http://localhost/containers/49f0b2c8b1/stop

# 2 delete
curl --unix-socket /var/run/docker.sock -X DELETE  -H "Content-Type: application/json" http://localhost/containers/49f0b2c8b1

# delete Force true
curl --unix-socket /var/run/docker.sock -X DELETE  -H "Content-Type: application/json" http://localhost/containers/49f0b2c8b1?force=true