# Create a cluster kubernetes
k3d cluster create mycluster --servers 3 --agents 3 --port "8082:30080@loadbalancer:*" --api-port localhost:6443  --volume "C:/demo/data:/data@all"

k3d cluster list

#output
NAME        SERVERS   AGENTS   LOADBALANCER
mycluster   3/3       3/3      true

#creating a PV
echo > pv.yaml

kubectl apply -f pv.yaml

kubectl get pv 

# output status available
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   500Mi      RWO            Retain           Available           local-storage   <unset> 


#creating a PVC
echo > pvc.yaml

kubectl apply -f pvc.yaml

kubectl get pvc

#output
NAME     STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS    VOLUMEATTRIBUTESCLASS   AGE
my-pvc   Bound    local-pv   500Mi      RWO            local-storage   <unset>     


# get pv second time, it is no longer available, but bounded

kubectl get pv

# output
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   500Mi      RWO            Retain           Bound    default/my-pvc   local-storage   <unset> 

# create the POD
 kubectl apply -f deployment.yaml

 # pods
 kubectl get pods

 # access the pod terminal

 kubectl exec -it nginx-deployment-58549b5974-pg5bj -- /bin/bash

# pod sh
root@nginx-deployment-58549b5974-pg5bj:/#
cd /usr/share/nginx/html

touch sample.txt

ls

exit

# get deployments

kubectl get deployments

#output
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   1/1     1            1           3m5s

kubectl delete deployment nginx-deployment 