# Readiness

The application is ready?

It can respond the request? it can process dataa?

it does not restart the application.

## http
```bash

http://localhost:30000/ready

# now click on "Aplicacao nao disponivel" button

kubectl get endpoints

# the endppint of the service is removed because the application is not ready.
# to solve it, we always have a second replica of our pod.

```

## Exec

```bash

kubectl apply -f deploy-probe-readiness-exec.yaml

kubectl get endpoints


```


## TCP


```bash

kubectl apply -f deploy-probe-readiness-tcp.yaml

kubectl get endpoints


```