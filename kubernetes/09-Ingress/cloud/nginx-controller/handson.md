# Igress


## 1. Creating a Kubernetes Kluster for a Postgress service

Using  Digital Ocean

- Download the kube.config
- update your local kube.config


## 2.  Unsing the Igress-Nginx   Controller


[ Ingress-Nginx Controller ](https://kubernetes.github.io/ingress-nginx/deploy/)

- 1. [Choose Digital Ocean](https://kubernetes.github.io/ingress-nginx/deploy/#digital-ocean)
- 2. run  the command

```bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.14.1/deploy/static/provider/do/deploy.yaml

```

so you should look for the objects in that namespaces


```bash

# get the namespace
kubeclt get ns

# namespace
kubectl get all -n ingress-nginx

```

Get the public up and access via browser

```

https://44.55.105.69


```
## Ged domain

[Go Addy](https://www.godaddy.com/en/offers/godaddy?isc=sem3year&countryview=1&currencyType=EUR&cdtl=c_15415727694.g_138386971815.k_kwd-88659201.a_740350784800.d_c.ctv_g&bnb=b&gad_source=1&gad_campaignid=15415727694&gbraid=0AAAAAD_AGdxEsVxDcmEgS6NjOr5FkiYss&gclid=CjwKCAiA7LzLBhAgEiwAjMWzCCt-EQCbCjE83Gevz3CkesLr6gVL0gk8yHVnXQrqh4ZuY0Dg-5temBoCAQQQAvD_BwE)

you can buy a domain.

Mapping the Domain with Ip

![](../../images/13.png)

## Commands

```powershell

# get pods
kubectl get po -n ingress-nginx

# get service
kubectl get svc -n ingress-nginx


# delete
kind delete cluster --name mycluster

```


