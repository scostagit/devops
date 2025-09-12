docker build -t sergiodoc/app-go:v1 .

docker run -d -p 8080:8080 sergiodoc/app-go:v1


# building an intermediate image (build in our case)
# use the attribute target.
docker build -t sergiodoc/app-go:v1 --target=build .
 
# checking the container folder
docker exec -it  45644g5645g4 /bin/sh

docker build -t sergiodoc/app-go:v3 -f Dockerfile-multistage .