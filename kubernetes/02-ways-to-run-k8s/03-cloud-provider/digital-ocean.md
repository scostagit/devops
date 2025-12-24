# Digital Ocean


[Kubernetes Dashboard](https://cloud.digitalocean.com/kubernetes/clusters?i=22e605)


this is the best option to use Kubenertes. Kubernetes as service.

youb don't have to worry about the CNI, scripts, manager machines.

***This is the best option to start***

1 Create a new cluster kubenetes, go to actions and download config file.

2 open your local kube config and replace to the digital ocean config file.

kube config

```
%USERPROFILE%\.kube\config
```

```bash

kubectl get nodes

# digital ocean nodes
NAME                   STATUS   ROLES    AGE    VERSION
pool-qqdjhb82p-5oaeb   Ready    <none>   7m8s   v1.34.1
pool-qqdjhb82p-5oaej   Ready    <none>   7m4s   v1.34.1
pool-qqdjhb82p-5oaer   Ready    <none>   7m4s   v1.34.1

```

### Deploying the Web app on the cloud service Kubernetes cluster


```bash

kubectl apply -f deploy.yaml

kubectl get po

# output
NAME                        READY   STATUS              RESTARTS   AGE
conversao-f9554d5bd-b4959   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-bqclb   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-dgd9c   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-g2q69   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-lw9js   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-nrhbs   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-psmm4   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-rpstn   0/1     ContainerCreating   0          12s
conversao-f9554d5bd-tng4p   0/1     ContainerCreating   0          12s


# 1 miunute later

NAME                        READY   STATUS    RESTARTS   AGE
conversao-f9554d5bd-b4959   1/1     Running   0          44s
conversao-f9554d5bd-bqclb   1/1     Running   0          44s
conversao-f9554d5bd-dgd9c   1/1     Running   0          44s
conversao-f9554d5bd-g2q69   1/1     Running   0          44s
conversao-f9554d5bd-lw9js   1/1     Running   0          44s
conversao-f9554d5bd-nrhbs   1/1     Running   0          44s
conversao-f9554d5bd-psmm4   1/1     Running   0          44s
conversao-f9554d5bd-rpstn   1/1     Running   0          44s
conversao-f9554d5bd-tng4p   1/1     Running   0          44s
conversao-f9554d5bd-w5r4w   1/1     Running   0          44s

```

Getting service info


```bash

kubectl get svc

NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
conversao    NodePort    10.108.56.87   <none>        80:30000/TCP   2m37s
kubernetes   ClusterIP   10.108.32.1    <none>        443/TCP        15m

```

### Load Balancer

As we can see our service is a NodePort type, when we are running our cluster on the cloud provider,
the best option is use the loadbalancer type.

```yaml

spec:
  selector:
    app: conversao
  type: LoadBalancer #changed
  ports:
    - port: 80
      targetPort: 8080
      name: http
      protocol: TCP
      #nodePort: 30000 # removed

```

Run the apply command to re-deploy the web applicaton on the Kubenerte cluster

```bash

kubectl apply -f deploy.yaml

kubectl get svc

# Now our service is a LoadBalancer
# we are waiting a public IP to be provisioned.

NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
conversao    LoadBalancer   10.108.56.87   <pending>     80:30000/TCP   7m16s
kubernetes   ClusterIP      10.108.32.1    <none>        443/TCP        19m


# Now we have the public ip:
kubectl get svc

NAME         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
conversao    LoadBalancer   10.108.56.87   143.244.202.22   80:30000/TCP   9m15s
kubernetes   ClusterIP      10.108.32.1    <none>           443/TCP        21m

```

Now go to the browser and access the public ip:

```
 http://143.244.202.22/

 ```

 You can access the application now.




```bash

kubectl get all

# All the resources of our kubernetes cluster: 

NAME                            READY   STATUS    RESTARTS   AGE
pod/conversao-f9554d5bd-b4959   1/1     Running   0          12m
pod/conversao-f9554d5bd-bqclb   1/1     Running   0          12m
pod/conversao-f9554d5bd-dgd9c   1/1     Running   0          12m
pod/conversao-f9554d5bd-g2q69   1/1     Running   0          12m
pod/conversao-f9554d5bd-lw9js   1/1     Running   0          12m
pod/conversao-f9554d5bd-nrhbs   1/1     Running   0          12m
pod/conversao-f9554d5bd-psmm4   1/1     Running   0          12m
pod/conversao-f9554d5bd-rpstn   1/1     Running   0          12m
pod/conversao-f9554d5bd-tng4p   1/1     Running   0          12m
pod/conversao-f9554d5bd-w5r4w   1/1     Running   0          12m

NAME                 TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
service/conversao    LoadBalancer   10.108.56.87   143.244.202.22   80:30000/TCP   12m
service/kubernetes   ClusterIP      10.108.32.1    <none>           443/TCP        25m

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/conversao   10/10   10           10          12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/conversao-f9554d5bd   10        10        10      12m

```
