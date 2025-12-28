# Deploying  Kubenews Web App

## 1 - Web Appplication
1 - Fork and clone the repo

[Kubenews repo](https://github.com/KubeDev/kube-news)

2 - build and push the docker imagem

Dockerfile:

```dockerfile

FROM node:20.11.0
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]

```

```bash

# v1
docker build -t sergiodoc/aula-kube-news:v1 --push .

# latest
docker build -t sergiodoc/aula-kube-news:latest --push .

```

## 2 - Cluster Kubernetes using Kind

Create yaml file called "kind-config.yaml":

```yaml

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true # I disabled this one, we should install calico
nodes:
  - role: control-plane
    image: kindest/node:v1.34.3
    extraPortMappings:
     - containerPort: 30000
       hostPort: 30000
       listenAddress: "0.0.0.0"
       protocol: TCP
  - role: control-plane
    image: kindest/node:v1.34.3
  - role: control-plane
    image: kindest/node:v1.34.3
  - role: worker
    image: kindest/node:v1.34.3
  - role: worker
    image: kindest/node:v1.34.3
  - role: worker
    image: kindest/node:v1.34.3
  - role: worker
    image: kindest/node:v1.34.3



```


Run the command to create the kubernetes cluster

```bash

kind create cluster --name mycluster --config kind-config.yaml

kubectl get nodes

```

if is there an error on kind, try to use k3d:

```bash

k3d cluster create mycluster --servers 3 --agents 3 --port "30000:30000@loadbalancer:*" --api-port localhost:6443


kubectl get nodes
```


## 3 - Setup the database

Create a folder called "k8s" to hold all the files related with our deployment. Creatge a new file called "deploy.yaml". Let's work in the manifest file now.

deploy.yaml:

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
spec:
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      containers:
      - name: postgresql
        image: postgres:15.0
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_PASSWORD
          value: "Pg#123"
        - name: POSTGRES_USER
          value: "kubenews"
        - name: POSTGRES_DB
          value: "kubenews"

---

apiVersion: v1
kind: Service
metadata:
  name: postgresql
spec:
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432

```

Now apply the configuration 

```bash

kubectl apply -f k8s/deploy.yaml

kubectl get po


```

The database service is a  ***ClusterIp***, it means it won't be accessible outside our internal environment. 

If want to test our database connectivity, we should use the porforward command.

```bash

kubectl get svc

kubectl port-forward service/postgresql 5432:5432

```

# IMPORTANT PORT-FORWARD

```bash

kubectl port-forward svc/postgresql 5432:5432

```


You can use the DBeaver to test it

## 4 Deploying the web application

It is a good practise to keep all service together in the deploy.yaml file:

***deploy.yaml***:


```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
spec:
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      tolerations:
        - key: "node-role.kubernetes.io/control-plane"
          operator: "Exists"
          effect: "NoSchedule"
      containers:
      - name: postgresql
        image: postgres:15.0
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_PASSWORD
          value: "Pg#123"
        - name: POSTGRES_USER
          value: "kubenews"
        - name: POSTGRES_DB
          value: "kubenews"

---

apiVersion: v1
kind: Service
metadata:
  name: postgresql
spec:
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubenews
spec:
  replicas: 10
  selector:
    matchLabels:
      app: kubenews
  template:
    metadata:
      labels:
        app: kubenews
    spec:
      containers:
      - name: kubenews
        image: sergiodoc/aula-kube-news:v1
        ports:
        - containerPort: 8080
        env:
        - name: DB_PASSWORD
          value: "Pg#123"
        - name: DB_USERNAME
          value: "kubenews"
        - name: DB_DATABASE
          value: "kubenews"
        - name: DB_HOST
          value: postgresql
---
apiVersion: v1
kind: Service
metadata:
  name: kubenews
spec:
  selector:
    app: kubenews
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30000
  type: NodePort

```


Now you can access the appliation using the url

```

http://localhost:30000

```


## 5 Deploying on the cloud 

As you don't have access to the machines or pods on the cloud, we have to change the type of the service from **NodePort** to **LoadBalancer**:

```yaml

apiVersion: v1
kind: Service
metadata:
  name: kubenews
spec:
  selector:
    app: kubenews
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30000
  type: LoadBalancer
```


Checking the public IP generated by the digital Ocean:

```bash

kubectl get svc

```

## Challenge 

Change the configuration to use secret or configMap.


# Secrets

Absolutely! We can improve your YAML by moving sensitive information like database passwords, usernames, and database names into **Kubernetes Secrets**. This makes your deployment more secure and manageable. Here's a fully refactored version using secrets:

```yaml
# -------------------------
# Kubernetes Secret
# -------------------------
apiVersion: v1
kind: Secret
metadata:
  name: kubenews-db-secret
type: Opaque
stringData:
  POSTGRES_PASSWORD: "Pg#123"
  POSTGRES_USER: "kubenews"
  POSTGRES_DB: "kubenews"

# -------------------------
# PostgreSQL Deployment
# -------------------------
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
spec:
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      tolerations:
        - key: "node-role.kubernetes.io/control-plane"
          operator: "Exists"
          effect: "NoSchedule"
      containers:
        - name: postgresql
          image: postgres:15.0
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_PASSWORD
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_USER
            - name: POSTGRES_DB
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_DB

# -------------------------
# PostgreSQL Service
# -------------------------
---
apiVersion: v1
kind: Service
metadata:
  name: postgresql
spec:
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432

# -------------------------
# Kubenews Deployment
# -------------------------
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubenews
spec:
  replicas: 10
  selector:
    matchLabels:
      app: kubenews
  template:
    metadata:
      labels:
        app: kubenews
    spec:
      containers:
        - name: kubenews
          image: sergiodoc/aula-kube-news:v1
          ports:
            - containerPort: 8080
          env:
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_PASSWORD
            - name: DB_USERNAME
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_USER
            - name: DB_DATABASE
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_DB
            - name: DB_HOST
              value: postgresql

# -------------------------
# Kubenews Service
# -------------------------
---
apiVersion: v1
kind: Service
metadata:
  name: kubenews
spec:
  selector:
    app: kubenews
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30000
  type: NodePort
```

✅ **Key improvements:**

1. Sensitive data moved to a Kubernetes Secret (`kubenews-db-secret`).
2. Both `postgres` and `kubenews` deployments reference the secret using `valueFrom.secretKeyRef`.
3. Passwords, usernames, and database names are no longer in plain text in your deployments.


## Encrypt Base64

YAML using **base64-encoded values**:

```yaml
# -------------------------
# Kubernetes Secret (base64 encoded)
# -------------------------
apiVersion: v1
kind: Secret
metadata:
  name: kubenews-db-secret
type: Opaque
data:
  POSTGRES_PASSWORD: "UGgjMTIz"   # Base64 for "Pg#123"
  POSTGRES_USER: "a3ViZW5ld3M="  # Base64 for "kubenews"
  POSTGRES_DB: "a3ViZW5ld3M="    # Base64 for "kubenews"

# -------------------------
# PostgreSQL Deployment
# -------------------------
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
spec:
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      tolerations:
        - key: "node-role.kubernetes.io/control-plane"
          operator: "Exists"
          effect: "NoSchedule"
      containers:
        - name: postgresql
          image: postgres:15.0
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_PASSWORD
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_USER
            - name: POSTGRES_DB
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_DB

# -------------------------
# PostgreSQL Service
# -------------------------
---
apiVersion: v1
kind: Service
metadata:
  name: postgresql
spec:
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432

# -------------------------
# Kubenews Deployment
# -------------------------
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubenews
spec:
  replicas: 10
  selector:
    matchLabels:
      app: kubenews
  template:
    metadata:
      labels:
        app: kubenews
    spec:
      containers:
        - name: kubenews
          image: sergiodoc/aula-kube-news:v1
          ports:
            - containerPort: 8080
          env:
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_PASSWORD
            - name: DB_USERNAME
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_USER
            - name: DB_DATABASE
              valueFrom:
                secretKeyRef:
                  name: kubenews-db-secret
                  key: POSTGRES_DB
            - name: DB_HOST
              value: postgresql

# -------------------------
# Kubenews Service
# -------------------------
---
apiVersion: v1
kind: Service
metadata:
  name: kubenews
spec:
  selector:
    app: kubenews
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30000
  type: NodePort
```
