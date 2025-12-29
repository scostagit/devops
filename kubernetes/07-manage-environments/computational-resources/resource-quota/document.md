# Resource Quota

It manages the resouces not in the POD level, but the **namespace** level.

You can limit resources for DEV, UAT or Production environments.

Ex.: Limit max or mim cpu for the namespace.

Machine learn uses GPU not CPU.

- Limit PODs

You can limit the number os PODs


## Quota for computacional resources
```bash


kubectl apply -f quota.yaml

kubectl get resourcequota

kubectl resourcequota descibe   rr t

kubectl apply -f deploy.yaml

kubectl get pod -o wide

kubectl get rs

kubectl describe rs jrksxrk


```


# Quota for Objects


```bash


kubectl apply -f quota-for-objects.yaml

kubectl get resourcequota

kubectl resourcequota descibe  fggf

kubectl apply -f deploy.yaml

kubectl get pod -o wide

kubectl get rs

kubectl describe rs jrksxrk


```

```yaml

spec:
  replicas: 5  #fails becuase I set the pod limits to "4"
  selector: 
    matchLabels:
      app: web
```

# Take aways

- The resource quota is a level of namaspace
- Create the Load test for your app, get the parameters from there. and set your max and min.

