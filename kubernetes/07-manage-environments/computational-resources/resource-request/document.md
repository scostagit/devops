# Resource request

It is  a good practice to define the minimal request for your containers.


```yaml

   resources:
    requests:
        cpu: "0.2"
        memory: 64Mi
    limits:
        cpu: "0.4"
        memory: 128Mi
```

```bash

kubectl apply -f deploy.yaml

kubectl get pod -o wide

```

# Pod status Peding

the k8s dosn't have cpu enough to run the POD.

# Quality of Service

Prioripry

- 1 Garanteed: high priority. The pod will always run.
- 2 Burstable: Middium priorioty
- 3 BestEffot: will be excluded first. Low priority




