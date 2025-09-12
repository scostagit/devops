# create an image from a container instance
docker commit

# create an image from a dockerfile
docker build

docker image ls

# remove
docker image rm 

#remove all images that is not being used
docker image prune 

#remove an iamge by name
docker image rm ubuntu-crul 


docker build -t myapp .

docker build -t myapp:v1.0 .
