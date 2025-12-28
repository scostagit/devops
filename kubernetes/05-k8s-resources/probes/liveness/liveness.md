# Liveness

The application is health?

You can ask Kubernetes to take care of your application, like make a internal http request, or tcp port ping or exec a command.


1 - Http


```bash

http://localhost:30000/heath

#output
ok


```

When you click on "Quebrar a applicao", the pod still running but the application is no longer health, because the http request is not responding.

you can delete the pod using this command:

```bash

kubectl delete pod ahfkjhfk

```
The replicaset will create the pod again, but the problem is you're doing it manually, second **you're recreating the Pod**.

When you use liveness, it does not recreate the pods, but the container!!
much better

2 - TCP

```bash

kubectl apply -f deploy-probe-liveness-exec.yaml
kubectl exec -it simulador-do-cqos-5645454gojkj --bin/sh

cd tmp/
ls

#output
health

# remove the file, so the application is no longer health.
rm health

```

3 - EXEC

