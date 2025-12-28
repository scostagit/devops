# Override the entry and args

Wheneer you want to change the beheviours of your containers like we did using on docker like entrypoint

```bash

docker container run --entrypoint echo ubuntu "Hello World!"

```

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: exec
  labels:
    app: exec
spec:
  containers:
  - name: exec
    image: busybox
    command: # => Entrypoint
    - /bin/sh
    args: # => CMD
    - -c
    - touch /tmp/teste.txt; sleep 120;
  restartPolicy: Never

```