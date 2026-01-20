# Igress


## 1. Creating a Kubernetes Kluster for a Postgress service

Using Kind


```powershell


# I set the image inside the yaml file
kind create cluster --name mycluster --config kind-config.yaml

# List Clusters
kind get clusters

kind delete cluster

kind delete cluster --name mycluster

```

## 2.  Unsing the Igress-Nginx   Controller


[ Ingress-Nginx Controller ](https://kubernetes.github.io/ingress-nginx/)

- 1. [Choose the Bare metal](https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal-clusters)
- 2. [download yaml file](https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.14.1/deploy/static/provider/baremetal/deploy.yaml)
- 3. set the NodePort

  ```yaml

       ...

        - appProtocol: http
            name: http
            port: 80
            protocol: TCP
            targetPort: http
            nodePort: 30000 # my change here line 365
      ...
  ```


so you should look for the objects in that namespaces


```powershell

# Important !!!
kubeclt get all -n ingress-nginx

```

Open the broser and type

```

localhost

```


### Calico

Nodes with the status `NotReady`

```bash
 
kubectl get nodes

# Result

NAME                       STATUS     ROLES           AGE   VERSION
mycluster-control-plane    NotReady   control-plane   18m   v1.34.3
mycluster-control-plane2   NotReady   control-plane   17m   v1.34.3
mycluster-control-plane3   NotReady   control-plane   17m   v1.34.3
mycluster-worker           NotReady   <none>          17m   v1.34.3
mycluster-worker2          NotReady   <none>          17m   v1.34.3
mycluster-worker3          NotReady   <none>          17m   v1.34.3
mycluster-worker4          NotReady   <none>          17m   v1.34.3
```

Agora, se você executar o kubectl get nodes, vai ver que o control plane e os nodes não estão prontos, pra resolver isso, é preciso instalar o Container Network Interface ou CNI, aqui eu vou usar o Calico

**Instalação do CNI**

```bash
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml
```

- 4. Apply

  ```

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.14.1/deploy/static/provider/baremetal/deploy.yaml

    # deploying the igress
    kubectl apply -f deployment.yaml

  ```

 **The igress will be deployed on ` ingress-nginx` the namespace:**

```yaml

kind: Namespace
metadata:
  labels:
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/name: ingress-nginx
  name: ingress-nginx

```



### Local DNS (Domain Name Service)

You can simulate a DSN in your local machine updating the hosts file:

```

Windows C:\Windows\System32\drivers\etc\hosts

Linux /etc/hosts

Mac /private/etc/hosts


```

undo your changes the host file after the lad.

#### nip.io

For Domain and sub-domain: 
Or use a tool called nip.io, which works like a local DNS.

[Documentation of nip.io](https://nip.io/)



## Commands

```powershell

# get pods
kubectl get po -n ingress-nginx

# get service
kubectl get svc -n ingress-nginx

# port forward
kubectl port-forward service/conversao 8080:80 -ningress-nginx

# delete
kind delete cluster --name mycluster

```


