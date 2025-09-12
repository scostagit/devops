
# local database
docker container run -d -e POSTGRES_PASSWORD=Pg123 -e POSTGRES_USER=kubenes -e POSTGRES_DB=kubnews -p 5432:5432 -v kubnews_vol:/var/lib/postgresql/data postgres:14.10




# running web app application
DB_DATABASE=kubnews DB_USERNAME=kubenes DB_PASSWORD=Pg123 DB_HOST=localhost DB_PORT=5432 node server.js