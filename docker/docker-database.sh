# mount bind
docker container run -d -e POSTGRES_PASSWORD=123456 -p 5432:5432 --mount type=bind,source="$(pwd)/db_vol",target=/var/lib/postgresql/data postgres


sudo cd db_vol

sudo ls -a

# give permission to folder db_vol
sudo chmod 777 db_vol/


# mount docker volume
docker container run -d -e POSTGRES_PASSWORD=123456 -p 5432:5432 --mount type=volume,source="container_postgree_vol",target=/var/lib/postgresql/data postgres

docker container ls

docker  volume ls 

# output: =============================
# DRIVER    VOLUME NAME
# local     aula_vol
# local     container_postgree_vol




# local database
docker container run -d -e POSTGRES_PASSWORD=Pg123 -e POSTGRES_USER=kubenes -e POSTGRES_DB=kubnews -p 5432:5432 -v kubnews_vol:/var/lib/postgresql/data postgres:14.10




# running web app application
DB_DATABASE=kubnews DB_USERNAME=kubenes DB_PASSWORD=Pg123 DB_HOST=localhost DB_PORT=5432 node server.js