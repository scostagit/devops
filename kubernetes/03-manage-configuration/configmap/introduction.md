 # Config Map

 It is a kubernetes object to save data in key-valoue format.

 you will have a collections of items of key-values object.


there are two ways to setup the config map

1 - imperative: command line
2 - declarative: yaml file



```bash

kubectl get configmap

NAME               DATA   AGE
kube-root-ca.crt   1      43m

```

Creating config map


```bash


 kubectl create configmap app-config --from-literal=APP_NAME="my application from config map"

#output:
configmap/app-config created


# get the confgig map

kubectl get configmap

#output:
NAME               DATA   AGE
app-config         1      13s
kube-root-ca.crt   1      47m


kubectl describe configmap app-config

#output:
Name:         app-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
APP_NAME:
----
my application from config map


BinaryData
====

Events:  <none>

```

### Deleting a config map

```bash

kubectl delete configmap app-config

```


## Creating from a file

```bash

echo "Test file" > test.config

kubectl create configmap app-config --from-file test.config
# output
configmap/app-config created


kubectl delete configmap app-config
# output 
configmap "app-config" deleted from default namespace
```


## YAML FILE

```bash

kubectl apply -f configmap.yaml

# output
configmap/app-config created

```


# Linked the configmap with the deploy.yaml

## 1 Way By reference:

```yaml

 envFrom:
    - configMapRef:
        name: app-config

```


## 2 Way by value:

```yaml

 envFrom:
    - configMapRef:
        name: app-config

```


Deletings all manifest files

```bash

kubectl delete -f .

```


Applying all manifest from a directory

```bash

kubectl apply -f .

```


# IMPORTANT !!!!

WHEN YOU UPDATE THE CONFIG MAP, IT DOES NOT UPDATE THE APPLICATION WHICH IS RUNNING INSIDE THE POD. YOU MUST DELETE THE POD TO LOAD THE NEW CONFIGURATION.