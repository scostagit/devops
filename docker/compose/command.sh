
# version
docker componse version

# version
docker compoae -f compose.yaml up

docker compose up

# backgrouod -d
docker compose up -d 

# remove the container
docker compose down


# stop the container
docker compose stop

# start the container
docker compose start

# removing containers
docker compose up -d --remove-orphans


# running a different file

docker compose -f host-compose.yaml up -d

# accessing the container bash
# docker exec -it [CONTAINER_NAME OR CONTAINER_ID] /bin/bash
docker exec -it a262e9ae2949 /bin/bash


# build an image and run
docker compose up -d --build

# build an image
docker compose --build

# pull  images
docker compose pull


# check the docker compose configuration (show the output)
docker compose config


# check the docker compose configuration (show the output)
docker compose --env-file dev.env config

docker compose --env-file dev.env up -d

# clear everything
docker system prune



# Multple docker compose files:
# Extend, Merge and Include


# Run with profile 
docker compose --profile dev up -d --build 


# show only the container inside your compose
docker compose ps

# show all container that is running
docker container ls

# show the out 
docker compose logs

# show a specific log
docker compose logs [contaienr_id]

# iteracts a container inside the compose
docker compose exec [contaienr_id]


# compose pull image
docker compose pull


# container push image
docker compose push

