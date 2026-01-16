# NFS

Network File Service

**NFS e sistema de compartilhamento de arquivos fora do meu cluster**

You can read the NFS from any work node. It is ReadToMany policy.

But...

Latency: The speed is so slowy, is not a disk connection but network.

## 1. Step one

### Ubuntu Local

- Go digital ocean portal, and create a NFS service
 - Get the public IP and access it via SH

 ```sh

ssh root@67.207.94.9

 ```

Primeiro eu devo instalar o NFS kernel server

```sh

sudo apt update && sudo apt install nfs-kernel-server --yes

```

Crio o diretório que quero compartilhar

```sh

sudo mkdir -p /mnt/nfs_shared 
sudo chown -R nobody:nogroup /mnt/nfs_shared/
sudo chmod 777 /mnt/nfs_shared/

```

Compartilhamento do diretório

Agora eu mapeio os diretório que vou utilizar

```sh

sudo vim /etc/exports


/mnt/nfs_shared *(rw,sync,no_subtree_check,no_root_squash,insecure)

:wq!

# to see the changes
sudo cat /etc/exports

```



- **/mnt/nfs_shared**: Caminho no servidor NFS que está sendo compartilhado. Representa a localização dos arquivos e diretórios disponíveis para os clientes NFS.
- * : Indica que qualquer cliente pode montar este compartilhamento, representando todos os endereços IP. Para maior segurança, pode ser substituído por endereços IP específicos ou faixas de IP.
- **rw**: Permissão de leitura e escrita para os clientes NFS, permitindo que modifiquem os arquivos no compartilhamento.
- **sync**: As modificações nos arquivos são escritas no disco antes que as operações sejam consideradas concluídas, aumentando a integridade dos dados.
- **no_subtree_check**: Desativa a verificação de sub-árvores para melhorar o desempenho do NFS, embora deva ser usada com cautela.
- **no_root_squash**: Desativa a transformação de solicitações do usuário root em solicitações não privilegiadas, aumentando o risco de segurança mas permitindo que o root nos clientes NFS tenha os mesmos privilégios que o root no servidor.
- **insecure**: Permite conexões de clientes NFS usando portas acima de 1024, necessário em alguns ambientes ou configurações de firewall.

Reinicio o serviço

```sh

sudo exportfs -a
sudo systemctl restart nfs-kernel-server

```

## 2. Creating the PV

```sh
kubectl apply -f pv.yaml

kubectl get pv

NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS         VOLUMEATTRIBUTESCLASS   REASON   AGE
db-pv-nfs   4Gi        RWO            Delete           Available           nfs-static-storage   <unset>   

```

## 3. Creating the PVC

```sh

kubectl apply -f pvc.yaml


kubectl get pvc

NAME     STATUS   VOLUME      CAPACITY   ACCESS MODES   STORAGECLASS         VOLUMEATTRIBUTESCLASS   AGE
db-pvc   Bound    db-pv-nfs   4Gi        RWO            nfs-static-storage   <unset>                 45s


# Now thwe pv is no longer available, it is bounded:
# We have linked them.

kubectl get pv 
NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS         VOLUMEATTRIBUTESCLASS   REASON   AGE
db-pv-nfs   4Gi        RWO            Delete           Bound    default/db-pvc   nfs-static-storage   <unset>    

```

# 4. DBeaver

```

Connect DBeaver:

| Field                    | What to put                                                   |
| ------------------------ | ------------------------------------------------------------- |
| **Host name/address**    |  `kubeclt get svc` --get the ip                               |
| **Port**                 | `5432` *(or whatever host port you mapped in Docker Compose)* |
| **Maintenance database** | `kubenews` *(or the database you defined in Docker Compose)*  |
| **Username**             | `kubenews` *(from your environment variables)*                |
| **Password**             | `pq123` *(from your environment variables)*                   |
| **Save password?**       | ON (so you don’t have to type it every time)                  |


```