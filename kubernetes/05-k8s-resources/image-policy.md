# Kubernetes Resources

## Image Pull Policy

Policy of pull of the docker images to create the pods.

 - Always: the images will be downloaded alwayws **DEFAULT**
 - IfNotPresent: the images will be downloaded if is not present locally
 - Never: you have the images localy, there is no need for download. **It is not common**, you won't use this one so much.



***NEVER USE THE IMAGE WITH THE TAG: LATEST BECAUSE THE IDEMPONTENCE***

```bash
# Create a cluster
k3d cluster create mycluster --servers 3 --agents 3 --port "30000:30000@loadbalancer:*" --api-port localhost:6443

#get nodes
kubectl get nodes

#create the pods
kubectl apply -f deploy.yaml

#get pods
kubectl get po

#get the po manisfest file
kubectl get pod -o yaml

```
Output:

By default, the image policy is ***always***, that means the image will download every time:

```
 imagePullPolicy: Always
```

Checking the events to creage the pod, the image is pulling everytime:
Normal  Pulling    5m32s  kubelet            Pulling image "kubedevio/web-color:latest"

```bash

kubectl describe pod web-649976c578-ssgtb

#output

Name:             web-649976c578-ssgtb
Namespace:        default
Priority:         0
Service Account:  default
Node:             k3d-mycluster-server-1/172.20.0.4
Start Time:       Sun, 28 Dec 2025 21:39:25 +0000
Labels:           app=web
                  pod-template-hash=649976c578
Annotations:      <none>
Status:           Running
IP:               10.42.1.3
IPs:
  IP:           10.42.1.3
Controlled By:  ReplicaSet/web-649976c578
Containers:
  web:
    Container ID:   containerd://e182508396579c1f9cda5109773432ecaf4059e76794722b119bbf1db2460724
    Image:          kubedevio/web-color:latest
    Image ID:       docker.io/kubedevio/web-color@sha256:7a821e9929b32a1e9a1f400c6b4181cd10a48774f757e146b9e98bb9f9937ec4
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 28 Dec 2025 21:39:32 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jqjkn (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-jqjkn:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  5m32s  default-scheduler  Successfully assigned default/web-649976c578-ssgtb to k3d-mycluster-server-1
  Normal  Pulling    5m32s  kubelet            Pulling image "kubedevio/web-color:latest"
  Normal  Pulled     5m25s  kubelet            Successfully pulled image "kubedevio/web-color:latest" in 6.613s (6.613s including waiting). Image size: 56565938 bytes.
  Normal  Created    5m25s  kubelet            Created container web
  Normal  Started    5m25s  kubelet            Started container web

```

```yaml

 spec:
    containers:
    - image: kubedevio/web-color:latest
      imagePullPolicy: Always
      name: web
      ports:
      - containerPort: 80
        protocol: TCP
      resources: {}

```
Chaning the Image Policy:

Mopdify the manisfest file with a new configuration, **imagePullPolicy**:

```yaml
  imagePullPolicy: IfNotPresent # Changed the image policiy
```


```bash

kubectl apply -f deploy.yaml

kubectl get po -o yaml


```

Output:

Realize that the image will not be downlod every time. 
**make sure to change the image version**

```yaml

spec:
    containers:
    - image: kubedevio/web-color:latest
      imagePullPolicy: IfNotPresent
      name: web
      ports:
      - containerPort: 80
        protocol: TCP

```