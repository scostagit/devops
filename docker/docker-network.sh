docker network ls


NETWORK ID     NAME      DRIVER    SCOPE
2b5dc04bf3e5   bridge    bridge    local  --> Scwhich -> Conect com varias outras redes 
33e191d8f524   host      host      local  --> Conecta o container a network do host
b0fee926b4a4   none      null      local  --> Isolo o container, nao vai concetividade


docker network inspect 2b5dc04bf3e5

[
    {
        "Name": "bridge",
        "Id": "2b5dc04bf3e52a504755b57f3db413f4cb97e00e4c6142e2846388f71fcd46aa",
        "Created": "2025-08-19T11:55:41.63980078+01:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv4": true,
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]


# ALL CONTAINER IS CONNECTED TO THE BRIDGE BY DEFAULT!! 

docker container inspect adbb05a3bbbe

# check the network ex:
{
     "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "MacAddress": "f2:ae:7f:ad:f9:67",
                    "DriverOpts": null,
                    "GwPriority": 0,
                    "NetworkID": "2b5dc04bf3e52a504755b57f3db413f4cb97e00e4c6142e2846388f71fcd46aa",
                    "EndpointID": "74566f6ceff64326bb819729a16921d1a1ec84e69743bf90f15f45caa1ec1c95",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "DNSNames": null
                }
        }
}
            
  

ubuntu ip: 172.17.0.3
nginx ip:  172.17.0.2

# go to the ubuntu container
apt update && apt install curl --yes


curl http://172.17.0.2


# result
root@8588fb0c8aa9:/# curl http://172.17.0.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


# ===========================================================================================
# ****** IMPORTANT **************************************************************************
# ===========================================================================================

# IT IS BAD PRACTICE ACCESS CONTAINER BY IP
# DO NOT DO IT
# BACAUSE CONTAINER DIES ANY TIME AND IT COMES BACK WITH ANOTHER IP ADDRESS
# USE A DNS FOR CONNECTION

# 15:30




# ===========================================================================================
# ****** CREATE A BRIDGE NETWORK ************************************************************
# ===========================================================================================

docker network create aula_docker

docker container run --name nginx -d nginx

docker container run -it ubuntu /bin/bash

# connect container to network
docker network connect aula_docker nginx

# disconnect container to network
docker network disconnect bridge nginx

docker network connect aula_docker [id_container]

# check documentation:
docker network create --help

# crete a network with subnet and getway
docker network create --subnet=10.0.0.0/16 --gateway=10.0.0.1 outra_rede_docker



# creting a new container connected with a specific network
docker container run --it --network outra_rede_docker ubuntu /bin/bash

docker container run -d --name webapp --network outra_rede_docker -p 8081:8080 sergiodoc/conversao-webapp


# deleting a network
docker network rm [ID] or [NAME]
docker network rm 2f757ae2df4d
docker network prune

# command to see the ai
ip address

# ouput

# | Interface | Purpose                                                                                |
# | --------- | -------------------------------------------------------------------------------------- |
# | `lo`      | Loopback interface — for internal communication on the host                            |
# | `enp0s3`  | Ethernet (or virtual NIC) — your main network connection                               |
# | `docker0` | Docker bridge — virtual network for containers to communicate with each other and host |


# to check the connectivy 

bridge link

# container create command network host
docker container run -d --network=host nginx

# after added the container in the host network, we can setup the DNS
#  ip addr show / ip a
docker container run -it --add-host sergiohost.com:10.0.2.15 ubuntu /bin/bash

# inside the container:
apt update && apt install curl --yes 

# check the hosts in the dns file:
cat /etc/hosts

127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::  ip6-localnet
ff00::  ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
10.0.2.15       sergiohost.com
172.17.0.2      7b74375151a0

curl http://sergiohost.com

# output                     
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


