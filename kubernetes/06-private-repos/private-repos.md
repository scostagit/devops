# Private repos

Maybe you don't want to share  your docker images on dockerhub.


## Create a private repo on docker hub

Docker hub allows you to create one private repo:

- 1 changes the image name using the docker tag command:

```bash

#remove all images
docker image rm -f $(docker image ls -q)

docker image pull fabricioveronez/web-color:blue
docker image pull fabricioveronez/web-color:green

docker tag fabricioveronez/web-color:blue sergiodoc/web-color-priv:blue
docker tag fabricioveronez/web-color:green sergiodoc/web-color-priv:green

docker push sergiodoc/web-color-priv:blue
docker push sergiodoc/web-color-priv:green


docker logout

docker image pull sergiodoc/web-color-priv:blue

#output
access denied

docker login

docker image pull sergiodoc/web-color-priv:blue

```

To use private repo on kubernetes, 
    1 - you should create a secret.
    2 - change the manifast file.


## Create the secret for the credentials.

K8s has a specific secret for credentials.

command line or yaml.

command line

```bash

# this approch works for all private repo such as azure aks, EC2, jfrog docker hub and so on


 kubectl create secret docker-registry docker-auth --docker-server=https://index.docker.io/v1/ --docker-username=sergiodoc --docker-email=serjinho.costa@gmail.com --docker-password= secret/docker-auth created

kubectl get secrect

kubectl get secret docker-auth -o yaml

# this command won't work because is missing the credentials, and I'm using a private
# repository
kubectl apply -f deploy.yaml

kubectl describe pod 4tet57t57

# authentication error


```

## Adding the secrets:

```yaml

 imagePullSecrets:
    - name: docker-auth #the name of your secret.

```

