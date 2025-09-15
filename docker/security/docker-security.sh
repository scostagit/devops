# create a new docker image

 docker build -t sergiodoc/projeto-caotico:v1 .


docker scout cves 

# docker scout 

# quickview
docker scout quickview projeto-caotico:v1

# docker scout checks the vulnerabilities of the dependencies.

# cves padrao publico de vulnerabilidades

docker scout cves sergiodoc/projeto-caotico:v1

docker scout cves --format markdown sergiodoc/projeto-caotico:v1 > vulnerabilities.md

# recommendations

docker scout recommendations sergiodoc/projeto-caotico:v1

# before the creation of the image you can check
# the vulnarilibiities of your project
# go to src folder and type:
docker scout quickview fs://.

docker scout cves fs://.

# push

sergiodoc/conversao-webapp



docker push sergiodoc/projeto-caotico:v1


# adding image to docker scout via dockert command line

docker scout repo enable --org sergiodoc sergiodoc/projeto-caotico:v1

# check the recommendations via command line:

docker scout recommendations sergiodoc/projeto-caotico:v1


# update the dockerfile with a new base image and buld and push 
# at the same time:
docker build -t sergiodoc/projeto-caotico:v2 --push .


# Compare two images
docker scout compare --to sergiodoc/projeto-caotico:v2  sergiodoc/projeto-caotico:v3

# update the node package vulneabilties

npm install --package-lock-only

npm audit fix --force

# scan the volnerabilities of the packages
docker scout sbom --format list sergiodoc/projeto-caotico:v4

# trivy

# installing downloand

https://github.com/aquasecurity/trivy/releases

# open the folder using the terminal and type
# command line:

trivy --version

# docker file

trivy config C:/devops/docker/security/projeto-caotico/src

trivy image sergiodoc/projeto-caotico:v1
trivy image sergiodoc/projeto-caotico:v4


trivy image --scanners vuln,misconfig,secret,license sergiodoc/projeto-caotico:v4


# SPDX format

trivy image --format spdx-json --output result-spdx.json sergiodoc/projeto-caotico:v5


# Cyclonedx format

trivy image --format cyclonedx --output result-cyclone.json sergiodoc/projeto-caotico:v5


# cosing

cosing generate-key-pair

cosing generate-key-pair --output-key-prefix my-key

# signing the image

docker build -t sergiodoc/projeto-caotico-signed:v1 .

cosign sign --key cosign.key sergiodoc/projeto-caotico-signed:v1

# checking who signed the image

cosign verify --key cosign.pub cosign.key sergiodoc/projeto-caotico-signed:v1

# setting some metadata
cosign sign --key cosign.key -a owner ="Sergio Costa" sergiodoc/projeto-caotico-signed:v1

# environment variable 
export COSIGN_KEY=$(cat cosign.key)

env

cosign sign --key env://COSIGN_KEY -a owner ="Sergio Costa" sergiodoc/projeto-caotico-signed:v1

# Capabilities

man 7 capabilities


docker container run -it ubuntu /bin/bash

# run this command inside the container terminal
mount -o bind /etc /mnt
##output: --> mount: /mnt: permission denied.

##Adding the capabilitiy
docker container run -it --cap-add=SYS_ADMIN ubuntu /bin/bash
### OR
docker container run -it --privileged ubuntu /bin/bash
### on the terminal:
mount -o bind /etc /mnt 
### it worked.

###OBs:  SYS_ADMIN is an high permission



