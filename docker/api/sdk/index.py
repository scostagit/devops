import docker

# local
client = docker.from_env()

# from external api
#client = docker.DockerClient("http://localhost")

print(client.containers.run("alpine", ["echo", "hello", "world"]))

# nginx
print(client.containers.run("nginx", detach=True, ports={"80/tcp":("0.0.0.0", 8080)}))


# list 
lista_containers = client.containers.list(all=True)

for item in lista_containers:
    print(f'{item.id} - {item.image.tags} - {item.name}')


#container = client.containers.get("54g54c545gc45g4")
#print(f'{container.id} - {container.image.tags} - {container.name}')
#print(container.logs())
#container.remove(force=True)
