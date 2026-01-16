# Hands On

```yaml
apiVersion: v1
kind: PersistentVolume # indicate that this YAML file describes a Kubernetes resource of kind “PersistentVolume” using the Kubernetes API version 1.
metadata:
  name: local-pv # assigns a name to the PV resource, which can be used to reference it within the cluster.
spec:
  capacity:
    storage: 500Mi # specifies the storage capacity of the PV, which is set to 500 megabytes (MiB). This PV provides 500MB of storage space.
  volumeMode: Filesystem # defines the volume mode as “Filesystem,” indicating that this PV is intended for file-based storage.
  accessModes:
    - ReadWriteOnce # meaning that the PV can be mounted as read-write by a single node at a time.
  persistentVolumeReclaimPolicy: Retain # defines the policy for what happens to the PV after a PVC that uses it is deleted. “Retain” means that the PV’s data is retained even if the associated PVC is deleted, and manual cleanup is required.
  storageClassName: local-storage # associates this PV with a particular StorageClass named “local-storage.”
  hostPath:
    path: /demo/data # is used to specify the actual location on the host machine where the storage for this PV is located. In this case, it is set to /mnt/pv-data. The PV’s storage is expected to be found at this path on the node where the PV is created.
```



[Link to the article](https://medium.com/@veerababu.narni232/kubernetes-volumes-storage-pv-pvc-and-storage-class-548a5ff86343)