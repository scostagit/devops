# reaname docker image

docker tag conversao-webapp sergiodoc/conversao-webapp:v1
docker tag conversao-webapp sergiodoc/conversao-webapp:latest

#  docker hub

#  Login
docker login

#  docker push
docker push sergiodoc/conversao-webapp:v1
docker push sergiodoc/conversao-webapp:latest

#  docker remove images
docker image rm -f $(docker image ls -q)

#  docker clear the whole env
docker system prune


#  docker pull
docker pull sergiodoc/conversao-webapp:v1

# or docker run which creates a container at sametime download the iamge
docker run -d -p 8080:8080 sergiodoc/conversao-webapp:latest