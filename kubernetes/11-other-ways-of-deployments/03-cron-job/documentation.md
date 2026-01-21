```bash

k3d cluster create mycluster --servers 3 --agents 3 --port "8082:30080@loadbalancer:*" --api-port localhost:6443

kubectl get nodes

```