# Secrets

It is here where you'll save your string connection, token and api keys.

The data is not readable from users.

key /values objects using the hash64.

It is good to use with azure key-vaults

## Types of secrets

### Opaque

  it is similar config map

### Service Account Token

  you store the keys externally



## Kubernetes scrects

```bash

kubectl get secrets

```


### Imperative

Let's create a secret using command line:

```bash

kubectl create secret generic app-secret --from-literal=APP_NAME="My appliacation from Secret 1.0" --from-literal=APP_VERSION="2.0" --from-literal=APP_AUTHOR="Joseph Bispo"

```


If youy try to get the secret you won't be able to see values

```bash

kubectl describe secret app-secret

# output

Name:         app-secret
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
APP_AUTHOR:   12 bytes
APP_NAME:     31 bytes
APP_VERSION:  3 bytes


```

## Getting the secret contentk

```bash

kubectl get secret -o yaml


#output

apiVersion: v1
items:
- apiVersion: v1
  data:
    APP_AUTHOR: Sm9zZXBoIEJpc3Bv
    APP_NAME: TXkgYXBwbGlhY2F0aW9uIGZyb20gU2VjcmV0IDEuMA==
    APP_VERSION: Mi4w
  kind: Secret
  metadata:
    creationTimestamp: "2025-12-27T22:03:36Z"
    name: app-secret
    namespace: default
    resourceVersion: "27748"
    uid: cd41964a-5565-4a20-a444-e5b71b319ebe
  type: Opaque
kind: List
metadata:
  resourceVersion: ""


```

Descrypt the values

```bash

# linux terminal
echo "TXkgYXBwbGlhY2F0aW9uIGZyb20gU2VjcmV0IDEuMA==" | base64 -d 

#output
My appliacation from Secret 1.0sergio@sergio:/$


```


## Declarative Way

We should encrypt the values of our keys

Linux Terminal:

```bash

echo -n "My Secret application" | base64

# output
TXkgU2VjcmV0IGFwcGxpY2F0aW9u


echo -n "1.0" | base64

# ouput
MS4w

# output 
echo -n "Mr. Bin" | base64
TXIuIEJpbg==

```


Now, we have to create the secrets in a declarative way:

```bash

kubectl apply -f secret.yaml

kubectl apply -f deploy.yaml

```

# KMS Kubernetes managner secrets

You can you improve the encrypt stuff.

