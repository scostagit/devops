# Rollouts

Used to check the versions and rollback.


In Kubernetes, a **rollout** is the process of updating a deployment from one version of an application to another. It's a key part of managing applications and ensuring they can be updated without causing downtime for users. 

***

### How It Works

Imagine you have a website running on a few servers. You want to update the website with a new feature. You can't just shut down the old version and start the new one, because users would see an error. A rollout handles this change gracefully.

Here’s the basic process:

1.  **You start the rollout:** You tell Kubernetes, "I want to change the image of my application to the new version." This is usually done by updating the deployment's configuration file.

2.  **Kubernetes creates new pods:** Kubernetes starts creating new pods that run the updated version of your application, right next to the old ones. 

3.  **Traffic is shifted:** Once the new pods are up and running and healthy, Kubernetes starts sending user traffic to them. It does this gradually, so some users are still on the old version while others are on the new one.

4.  **Old pods are removed:** As more traffic is directed to the new pods, Kubernetes begins to shut down the old pods one by one.

5.  **The rollout is complete:** When all the old pods are gone and all user traffic is being handled by the new pods, the rollout is finished.

***

### Key Features of a Rollout

* **Zero Downtime:** The primary benefit is that your application remains available throughout the entire update process. Users never see an outage.
* **Safety:** If something goes wrong with the new version (for example, it has a bug), Kubernetes can automatically stop the rollout. You can also manually **rollback** to the previous version with a single command.
* **Controlled Speed:** You can control how quickly the new version is introduced and the old version is removed. This is often done by specifying the number of old pods that can be unavailable at any time and how many new pods can be created in a single step.

In simple terms, a rollout is Kubernetes' smart and safe way of replacing an old version of your application with a new one without interrupting your users.


```powershell

kubectl get rs

kubectl describe myrs

# to check the history of the rollouts
kubectl rollout history deploy mydeployment

#go gaback latest version

kubectl rollout undo deploy mydeployment

kubectl get deploy,rs,pods 

# wath
kubectl apply -f replicaset.yaml; while ($true) {Clear-Host; kubectl get deploy,rs,pods; Start-Sleep -Seconds 2}

```