 
# 1 VOLUME BIND

# 1 go to you host machine and create a folder called aula_volue
 
# 2 bind the volume with your container

docker container run -it --mount type=bind,source="$(pwd)/aula_volume,target=/app" ubuntu /bin/bash
 
# 3 create a new file and check it our in your container and 
# visa-versa on your host machine.

echo "write something" >> file.txt


# V: you can simplify your command using -v
docker container run -d -p 8080:80 -v $(pwd)/aula_volume/html:/usr/share/nginx/html nginx


# map an unique file
docker container run -d -p 8080:80 -v $(pwd)/aula_volume/html/index.html:/usr/share/nginx/html/index.html nginx

# DOCKER VOLUME (managed by docker)

# creat a volume a container
docker volume create aula_vol

docker volume ls

docker volume inspect aula_vol

docker volume rm aula_vol

docker container run -it --mount type=volume,source="aula_vol,target=/app" ubuntu /bin/bash

sudo cat  ls /var/lib/docker/volumes/aula_vol/_data/file.txt

docker volume ls

docker container run -it -v f6d2d31c53a1fdac7706deedf9e759cf0c21f9bad6302be5171eb0466c95140e:/app  example-volume  /bin/bash/

docker volume prune

# DOCKER VOLUME BACKUP
# gets the container id of the volume you want to back up: container id: 43a832a62467
docker container run --rm  --volumes-from 43a832a62467 -v $(pwd)/backup:/backup ubuntu:22.04 tar cvf /backup/backup_serjinho.tar /app

# Restoring the backup to a new volume
docker volume create new_volume

docker container run -v $(pwd)/backup:/backup -v new_volume:/app ubuntu:22.04 tar xvf /backup/backup_serjinho.tar app/

docker volume inspect new_volume
[
    {
        "CreatedAt": "2025-08-11T18:06:18+01:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/new_volume/_data",
        "Name": "new_volume",
        "Options": null,
        "Scope": "local"
    }
]


docker run -it -v new_volume:/app ubuntu /bin/bash



# volume type file system
# as the data  will be at the RAM you don't have to specify the source
docker container run -it --mount type=tmpfs,target=/app ubuntu /bin/bash

# when you exit the continer the volume is gone. 

