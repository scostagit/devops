
docker compose up -d --build 

docker compose down

#check the result before to apply the commanc

docker compose -f compose.yaml -f .devcontainer/docker-compose.yml config

docker compose -f compose.yaml -f .devcontainer/docker-compose.yml config

#windows 
docker compose -f .\compose.yml -f .\.devcontainer\docker-compose.yml config

docker compose -f .\compose.yml  config

