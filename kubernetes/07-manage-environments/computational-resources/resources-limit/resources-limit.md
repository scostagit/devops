# Computational Resouces

CPU, RAM, Process

Request and limit

## Kubernetes Metric Server

It is an extension that you can install in your node. let's run a few command before install it.

```bash

kubectl get nodes


NAME                     STATUS   ROLES                       AGE    VERSION
k3d-mycluster-agent-0    Ready    <none>                      122m   v1.31.5+k3s1
k3d-mycluster-agent-1    Ready    <none>                      122m   v1.31.5+k3s1
k3d-mycluster-agent-2    Ready    <none>                      122m   v1.31.5+k3s1
k3d-mycluster-server-0   Ready    control-plane,etcd,master   123m   v1.31.5+k3s1
k3d-mycluster-server-1   Ready    control-plane,etcd,master   122m   v1.31.5+k3s1
k3d-mycluster-server-2   Ready    control-plane,etcd,master   122m   v1.31.5+k3s1

kubectl top nodes

NAME                     CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)
k3d-mycluster-agent-0    49m          0%       275Mi           1%
k3d-mycluster-agent-1    47m          0%       261Mi           1%
k3d-mycluster-agent-2    51m          0%       278Mi           1%
k3d-mycluster-server-0   84m          0%       797Mi           5%
k3d-mycluster-server-1   57m          0%       692Mi           4%
k3d-mycluster-server-2   56m          0%       704Mi           4%

kubectl top pod
NAME   READY   STATUS    RESTARTS   AGE
curl   1/1     Running   0          67m

```

(k8s Mettrics server)[https://github.com/kubernetes-sigs/metrics-server]

Installing

```bash

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


kubectl get po -n kube-system

NAME                                      READY   STATUS      RESTARTS   AGE
coredns-ccb96694c-g7xsq                   1/1     Running     0          128m
helm-install-traefik-crd-zhcsc            0/1     Completed   0          128m
helm-install-traefik-fsdk9                0/1     Completed   1          128m
local-path-provisioner-5cf85fd84d-nvm77   1/1     Running     0          128m
metrics-server-67cb997f8c-4vmgr           1/1     Running     0          106s #here!!
svclb-traefik-f0a0e693-62tpw              2/2     Running     0          127m
svclb-traefik-f0a0e693-7qjlz              2/2     Running     0          127m
svclb-traefik-f0a0e693-9fdhn              2/2     Running     0          127m
svclb-traefik-f0a0e693-b8cpt              2/2     Running     0          127m
svclb-traefik-f0a0e693-h7kqq              2/2     Running     0          127m
svclb-traefik-f0a0e693-tvqk5              2/2     Running     0          127m
traefik-5d45fc8cc9-77ldt                  1/1     Running     0          127m

# checking the logs
kubectl logs metrics-server-67cb997f8c-4vmgr -n kube-system

kubectl top nodes
```


# Manage CPU


Resouce limit

```bash

kubectl apply -f deploy.yaml

#linux 
watch 'kubectl top nodes'

#windows
while($true) { clear; kubectl top nodes; sleep 2 }


```

Pod will get the status Pression Edition, and the K8s will kill other pods on the cluster.

To solve it you should setup the resource limit in the manisfast file in container level.

```yaml
 spec:
      containers:
      - name: simulador-do-caos
        image: kubedevio/simulador-do-caos:v1
        ports:
        - containerPort: 3000
        resources:
          limits:
            cpu: "500m" #Here's the change half a cup 

```

```bash

kubectl apply -f deploy.yaml

kubectl describe pod 454544545

#...
Limits:
    cpu: 500m
#...


```

# Manage Memomry


```yaml

 resources:
    limits:
        cpu: "500m" 
        memory: 512Mi #changed, added memomry limit
```

```bash

kubectl apply -f deploy.yaml

kubectl get pod -o wide

```

## OOMKilled error 137

Out of memory error, when the pod reaches the memory limit. it is restarted.

