
# chexck info about docker version, stroge driver
docker info

# event
# create two terminals, one for events and other event
docker events


# period o time
docker events --since 2h

docker events --until 30m

docker events --filter event=create

# combine parameter
docker events --until 30m --filter event=create


docker events --until 30m --filter type=image


docker events --until 30m --filter type=network --filter event=create

# event check the documentation


docker logs [CONTAINER_ID]

# lock the terminal
docker logs --since 30m --folow [CONTAINER_ID]

# exact time 
docker logs --since '2025-09-09T:20:00Z' --folow [CONTAINER_ID]

# get the last line
docker logs --tail 3 [CONTAINER_ID]

# inspect
docker inspect [CONTAINER_ID / IMAGE_ID, VOLUME_ID]

docker container inspect [CONTAINER_ID]
docker image inspect [IMAGE_ID]
docker network inspect [NETWORK_ID]
# check how many container are connected.
docker network bridge 
docker volume inspect [VOLUME_ID]

# list the procdess running inside the container.
docker top [CONTAINER_ID]

# to kmow how much resources you container is consuming.
docker stats --no-stream [CONTAINER_ID]

# all container
docker stats --no-stream

# better visualization
docker stats --no-trunc