
# when you don't mention the paramter -f, it looks at the current 
# folder searching for the dockerfile file.

 #. -> comtext: empty means the current folder is the contest.

docker build -t ubuntu-curl -f Dockerfile .

docker image ls

docker run -it ubuntu-curl /bin/bash

curl https://google.com

# without cache
docker build -t ubuntu-curl -f Dockerfile . --no-cache

# without dockerfile parameters
docker build -t ubuntu-curl .

# if you change the order of our run command will change the 
# the cache

# to find info about the package
apt search curl


# workdir -> create a folder inside the filesytem of the docker image
docker run -it ubuntu-curl /bin/bash

# the terminanl will open at #/app folder


# remocve all container
docker container rm -f $(docker container ls -a -qa)

# zip a file
tar -zvcf test.tar.gz arquivos


docker image inspect ubuntu-curl


# on the terminal type env to check the environment variables
env

# changing the environment variables
docker run -it -e VALOR_DOCKER_ENV="NEw bobo" ubuntu-curl /bin/bash

# adding a volume
docker run -it -e VALOR_DOCKER_ENV="NEw bobo" -v /data:/data ubuntu-curl /bin/bash

# Capital P -> -P maps all ports from the container, but it will generate ransdom port
docker run -it -e VALOR_DOCKER_ENV="NEw bobo" -v /data:/data -P ubuntu-curl /bin/bash

docker run -it -e VALOR_DOCKER_ENV="NEw bobo" -v /data:/data -p 8080:80 ubuntu-curl /bin/bash



# CMD x ENTRYPOINT

# CMD => override
docker container run ubuntu echo sergio

#ENTRYPOIN => not override
#ENTRYPOIN NOT RECOMMEND
docker container run  --entrypoint echo  ubuntu-curl test

#using entropiny
docker container run ubuntu-curl

docker container run ubuntu-curl test

# history to check about how the image was built
docker history conversao-webapp

# inspect 
docker inspect conversao-webapp
