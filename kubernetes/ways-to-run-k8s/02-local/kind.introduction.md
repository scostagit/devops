# KIND

There are 3 ways to create a cluster kubernetes:

 - 1 On Promise with Kubeadm
 - 2 Local (containers)
 - 3 As Service AKS, EKS, Digital Ocean

[Kind](https://kind.sigs.k8s.io/)


```powershell

choco install kind


#this works
kind create cluster --image kindest/node:v1.34.3



kind create cluster 

kind get clusters

kind create cluster --name mycluster

kind delete cluster

kind delete cluster --name mycluster

```


## IMPORTANT

we can work with kind like we were working with k3d by command line.
Kind required the yaml files.



```powershell

# create kubernetes cluster
kind create cluster --image kindest/node:v1.34.3 --name mycluster --config kind-config.yaml

# I set the image inside the yaml file
kind create cluster --name mycluster --config kind-config.yaml

# deploy web application
kubectl apply -f deploy.yaml

# get pods
kubectl get po

# get service
kubectl get svc

# port forward
kubectl port-forward service/conversao 8080:80

# delete
kind delete cluster --name mycluster

```


## Using another CNI

I disabled the CNI on my yaml file, if I run command to create the cluster
we will see that the cluster is not ready because we have disabled it:


```yaml 

networking:
  disableDefaultCNI: true # I disabled this one, we should install calico
 
```

```powershell
# create the cluster
kind create cluster --name mycluster --config kind-config.yaml

# get nodes
kubectl get nodes

# output
NAME                       STATUS     ROLES           AGE     VERSION
mycluster-control-plane    NotReady   control-plane   2m39s   v1.34.3
mycluster-control-plane2   NotReady   control-plane   2m10s   v1.34.3
mycluster-control-plane3   NotReady   control-plane   107s    v1.34.3
mycluster-worker           NotReady   <none>          104s    v1.34.3
mycluster-worker2          NotReady   <none>          104s    v1.34.3
mycluster-worker3          NotReady   <none>          104s    v1.34.3
mycluster-worker4          NotReady   <none>          104s    v1.34.3



```
check that the STATUS is NotReady because we have **disable the default CNI**.

Let's add another CNI:


## Calico

Calico is another CNI

```powershell

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/calico.yaml

```

Run the command to get the pods, so we will see the nodes are ready again:

```powershell


kubectl get nodes

NAME                       STATUS   ROLES           AGE     VERSION
mycluster-control-plane    Ready    control-plane   10m     v1.34.3
mycluster-control-plane2   Ready    control-plane   10m     v1.34.3
mycluster-control-plane3   Ready    control-plane   9m47s   v1.34.3
mycluster-worker           Ready    <none>          9m44s   v1.34.3
mycluster-worker2          Ready    <none>          9m44s   v1.34.3
mycluster-worker3          Ready    <none>          9m44s   v1.34.3
mycluster-worker4          Ready    <none>          9m44s   v1.34.3


```

now the nodes's status is READY.

## Local IMAGES

Kind allows you to work with images from your local machine without any registry associated to it

Deploy.yaml:

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: conversao
spec:
  replicas: 10
  selector:
    matchLabels:
      app: conversao
  template:
    metadata:
      labels:
        app: conversao
    spec:
      containers:
        - name: conversao
          image: fabricioveronez/conversao-temperatura-kind:v1 #local image, it isn't on Docker hub.
          ports:
            - containerPort: 8080
              name: http
              protocol: TCP
```

Kind command to load the image from your local environment:

```powershell

# load the image into kind
kind load --name mycluster docker-image fabricioveronez/conversao-temperatura-kind:v1

# deploy image
kubectl apply -f deploy.yaml

```