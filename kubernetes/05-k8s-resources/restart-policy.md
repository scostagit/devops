# Restart Policy

Restart with there is error

 - Always: Restart the pod always pod
 - OnFailure: Restart the pods on failure
 - Never: never restart the pods.

 ***THIS POLICY ONLY WORKS ON POD LEVEL, NOT IN THE DEPLOYMENT LEVEL. IT RESTART THE CONTANER NOT THE POD***

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    app: web
spec:
containers:
  - name: web
    image: kubedevio/simulador-do-caos:v1
    ports:
    - containerPort: 3000
restartPolicy: OnFailure
---

apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  type: NodePort
  ports:
  - port: 80
    targetPort: 3000
    name: http
    protocol: TCP
    nodePort: 30000

```