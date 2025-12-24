# NACKED POD

it is good for troubleshooting problems in the cluster



```powershell


kubectl run prompt --image nginx -it -- /bin/bash

#rm to remove

kubectl run prompt --rm --image nginx -it -- /bin/bash

apt update && apt-get install curl --yes

#new terminal, get pod ip
kubectl describe pod mydeployment-54d6d7db5b-k9q2z

# nacked pod
curl http://10.42.5.18

#output

root@prompt:/# curl http://10.42.5.18
<body style="text-align: center;background-color: green;">
   <H1>PÁGINA DE TESTE</H1>

    <h3> Servidor que processou a requisição - mydeployment-54d6d7db5b-k9q2z </h3>
    
```