                             
 Mysql                
                             
  docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD="root1234" -e MYSQL_DATABASE=auladocker -e MYSQL_USER=bozo -e MYSQL_PASSWORD=bozo123 mysql



Instsll dbevar

sudo add-apt-repository ppa:serge-rider/dbeaver-ce
sudo apt-get update
sudo apt-get install dbeaver-ce



//installing node
apt-get update
apt-get install -y curl
apt-get install -y nodejs npm



Web application

Go to the root folder of the project src and copy the files from host to a container folder:

host
cd src

cp . -> current dir, copy all files
container id: egsg4545g4fg

COMMAND
docker container cp . egsg4545g4fg:/app







Overlay

sudo apt install tree


sudo mkdir -p /overlay/primeira_camada
sudo mkdir -p /overlay/segunda_camada
sudo mkdir -p /overlay/work
sudo mkdir -p /overlay/merge



sudo echo "Arquivo teste na primeira camada" | sudo tee /overlay/primeira_camada/01_camada.txt

sudo echo "Arquivo teste na segunda camada" | sudo tee /overlay/segunda_camada/02_camada.txt

merge using mount


sudo mount -t overlay overlay -o lowerdir=/overlay/primeira_camada,upperdir=/overlay/segunda_camada,workdir=/overlay/work /overlay/merge

echo "Arquivo merged" | sudo tee /overlay/merge/merge.txt



padrao copy-on-write


sudo cat /overlay/merge/01_camada.txt

 echo "Arquivo alteracao no arquivo" | sudo tee /overlay/merge/01_camada.txt
 
 =============================================================================================
 
1 - start a new container
docker container run -it -p 8080:8080 ubuntu /bin/bash
 
 2 - instsll node
apt-get update
apt-get install -y curl
apt-get install -y nodejs npm


 3 - copy files
 
 docker container cp . egsg4545g4fg:/app
 
 4 - Docker commit
 run the container
 sop container
 
 docker commit [container-id] [image-name]
 
 docker commit  egsg4545g4fg conversao-temperatura
  
 docker images
 
 
 5 - run a new image
 docker container run -d -p 8080:8080 conversao-temperatura node /app/server.js
 
 
 
 ===================================
 IMAGES
 
 docker image ls
 
check how the image was built

docker image history [IMAGE_NAME OR IMAGE_ID] 
docker image history ubuntu

 
inspect
docker image inspect [IMAGE_NAME OR IMAGE_ID] 
docker image inspect ubuntu


save inspec

docker image inspect conversao > conversao-image.json

=====================================================
create a docker iamge manually

1 - we have to save and compact an image and save it a tar file:

docker image save conversaqo > image.tar

2 - descompact the file 
tar -xvf image.tar

3 - create 4 directorires

sudo mkdir -p /overlay-image/lower
sudo mkdir -p /overlay-image/upper
sudo mkdir -p /overlay-image/work
sudo mkdir -p /overlay-image/merged

ls /overlay-image


4 - copy the files tar into the folders:


--lower
sudo tar -xvf blobs/sha256/107cbdaeec042e6154640c94972c638f4e2fee795902b149e8ce9acbd03d59d7 -C //overlay-image/lower/


--upper
sudo tar -xvf blobs/sha256/af109e0889d9d6ce0e65e40786d883923343a250f28c030468b1c07ae5157975 -C //overlay-image/upper/


tree /overlay-image


5 - mount

 
sudo mount -t overlay overlay -o lowerdir=/overlay-image/lower,upperdir=/overlay-image/upper,workdir=/overlay-image/work /overlay-image/merged

 
6 - running the application in isolated process on linux, not in the container

sudo unshare --pid --fork --mount-proc chroot /overlay-image/merged 

node -v
cd app
node server.js


7 - umount
sudo umount /overlay-image/merged 

                                                            
 Dockefile
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
