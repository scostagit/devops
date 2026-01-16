

 ```sh


 kubectl apply -f limit.yaml

kubectl get limitrange

# result
NAME           CREATED AT
storagelimit   2026-01-16T22:52:24Z

kubectl describe limitrange


#result
Name:                  storagelimit
Namespace:             default
Type                   Resource  Min  Max  Default Request  Default Limit  Max Limit/Request Ratio
----                   --------  ---  ---  ---------------  -------------  -----------------------
PersistentVolumeClaim  storage   4Gi  6Gi  - 

# I should get an error
kubectl apply -f deployment.yaml 

deployment.apps/postgre created
service/postgre created
Error from server (Forbidden): error when creating "deployment.yaml": persistentvolumeclaims "db-pvc" is forbidden: minimum storage usage per PersistentVolumeClaim is 4Gi, but request is 3Gi



 ```

 Update the pvc to 5Gi so now it 's working


 ```yaml

 apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: do-block-storage #I got this name from the digital ocean cluster kubectl get storageclass. Just it we are done.
  resources:
    requests:
      storage: 5Gi #3Gi
      

 ```
Run apply again:

 ```sh

 kubectl apply -f deployment.yaml 

 ```