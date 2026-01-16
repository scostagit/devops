# HostPath

## O que é um volume no Kubernetes?

Pense em um **container** como um computador temporário:

* Ele nasce
* Roda o programa
* Morre

Tudo o que estiver **dentro dele** (arquivos, logs, dados) **se perde** quando ele morre.

👉 Um **volume** serve para **guardar dados fora do container**, para que eles não desapareçam.

---

## O que é o `hostPath`?

O **hostPath** é um tipo de volume que **liga uma pasta do computador (host)** onde o Kubernetes está rodando **diretamente dentro do container**.

📌 Em outras palavras:

> “Essa pasta do meu computador vira uma pasta dentro do container.”

---

## Analogia bem simples 🏠

Imagine que:

* O **host** é sua casa
* O **container** é um quarto alugado dentro da casa
* O **hostPath** é um armário da casa que o quarto pode usar

Mesmo que o quarto seja demolido (container apagado),
📦 **os itens no armário continuam lá**, porque pertencem à casa (host).

---

## Exemplo prático

Suponha que no seu computador (host) exista a pasta:

```
/dados/app
```

E você quer que o container enxergue isso como:

```
/app/dados
```

O Kubernetes faz esse “mapa” usando `hostPath`.

---

## Exemplo de YAML (simplificado)

```yaml
volumes:
  - name: dados-volume
    hostPath:
      path: /dados/app
      type: Directory
```

E no container:

```yaml
volumeMounts:
  - mountPath: /app/dados
    name: dados-volume
```

📌 Resultado:

* Tudo que o container grava em `/app/dados`
* Aparece também em `/dados/app` no host

---

## Para que o hostPath é usado?

Geralmente para:

* 🧪 **Ambientes de teste**
* 📜 Ler arquivos do host (logs, configs)
* 🛠️ Ferramentas que precisam acessar algo do sistema

---

## ⚠️ Atenção (parte importante)

O `hostPath` **não é recomendado para produção**, porque:

❌ O container fica **preso a um único nó**

❌ Pode causar **problemas de segurança**

❌ Não funciona bem se o pod mudar de máquina

👉 Em produção, normalmente usamos:

* PersistentVolume (PV)
* PersistentVolumeClaim (PVC)
* NFS, EBS, GCE PD, etc.

---

## Resumo em uma frase

> **hostPath é um volume que conecta diretamente uma pasta do computador onde o Kubernetes roda com o container.**



Step by steps

## 1. Creating a Kubernetes Kluster for a Postgress service

```sh
# Postgree Port 5482

k3d cluster create mycluster --servers 3 --agents 3 --port "5432:30080@loadbalancer:*" --api-port localhost:6443  

#k3d cluster create mycluster --servers 3 --agents 3 --port "5432:30080@loadbalancer:*" --api-port localhost:6443  --volume "C:/demo/data:/data@all"


kubctl get nodes

```

Yaml of the Postgree 

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgre
spec:
  selector:
    matchLabels:
      app: postgre
  template:
    metadata:
      labels:
        app: postgre
    spec:
      containers:
        - name: postgre
          image: postgres:15.0
          ports:
          - containerPort: 5432
          env:
          - name: POSTGRES_DB
            value: "kubenews"
          - name: POSTGRES_USER
            value: "kubenews"
          - name: POSTGRES_PASSWORD
            value: "pq123"  
          - name: PGDATA
            value: /var/lib/postgresql/data/pgdata
---
apiVersion: v1
kind: Service
metadata:
  name: postgre
spec:
  selector: 
    app: postgre
  ports:
    - port: 5432
      targetPort: 5432
      nodePort: 30080
  type: LoadBalancer
```


Runing the deployment

```sh

kubectl apply -f deployment.yaml


```

## 2. DBeaver docker


```

Connect DBeaver:

| Field                    | What to put                                                   |
| ------------------------ | ------------------------------------------------------------- |
| **Host name/address**    | localhost                                                     |
| **Port**                 | `5432` *(or whatever host port you mapped in Docker Compose)* |
| **Maintenance database** | `kubenews` *(or the database you defined in Docker Compose)*  |
| **Username**             | `kubenews` *(from your environment variables)*                |
| **Password**             | `pq123` *(from your environment variables)*                   |
| **Save password?**       | ON (so you don’t have to type it every time)                  |


```

## 3. Run the SQL script

```sql

CREATE TABLE noticias (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL CHECK (char_length(descricao) <= 2000)
);

INSERT INTO noticias (titulo, descricao) VALUES
('Título da Notícia 1', 'Descrição da notícia 1. Aqui vai um texto mais longo representando a descrição da primeira notícia.'),
('Título da Notícia 2', 'Descrição da notícia 2. Este é um exemplo de texto que pode ser usado como descrição para a segunda notícia.'),
('Título da Notícia 3', 'Descrição da notícia 3. Descrições podem variar em tamanho, mas esta é apenas uma demonstração.'),
('Título da Notícia 4', 'Descrição da notícia 4. Cada notícia pode ter uma história única e detalhes relevantes.'),
('Título da Notícia 5', 'Descrição da notícia 5. Informações importantes e atualizações podem ser incluídas aqui.'),
('Título da Notícia 6', 'Descrição da notícia 6. Notícias variam desde eventos locais até acontecimentos globais importantes.'),
('Título da Notícia 7', 'Descrição da notícia 7. Este texto serve como um exemplo para a inserção de registros.'),
('Título da Notícia 8', 'Descrição da notícia 8. A descrição fornece detalhes e contexto sobre a notícia.'),
('Título da Notícia 9', 'Descrição da notícia 9. Notícias podem influenciar a opinião pública e informar a comunidade.'),
('Título da Notícia 10', 'Descrição da notícia 10. Este é o último exemplo de notícia para completar a inserção de 10 registros.');

```


## 4. Host Path
  POD pointing to its path which points to a PVC.


It is Manual, you don't need PV, PVC or Storage Class.


```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgre
spec:
  selector:
    matchLabels:
      app: postgre
  template:
    metadata:
      labels:
        app: postgre
    spec:
      containers:
        - name: postgre
          image: postgres:15.0
          ports:
          - containerPort: 5432
          env:
          - name: POSTGRES_DB
            value: "kubenews"
          - name: POSTGRES_USER
            value: "kubenews"
          - name: POSTGRES_PASSWORD
            value: "pq123"  
          - name: PGDATA
            value: /var/lib/postgresql/data/pgdata
          volumeMounts:
            - name: db-vol
            - mountPath: /var/lib/postgresql/data
            - subPath: "pgdata"

      volumes: # level of POD, same volume of the containers
        - name: db-vol
          hostPath:
            path: /K3d/images
            type: Directory

      
---
apiVersion: v1
kind: Service
metadata:
  name: postgre
spec:
  selector: 
    app: postgre
  ports:
    - port: 5432
      targetPort: 5432
      nodePort: 30000
  type: LoadBalancer
```


# 5 Deployment volume

```sh

kubeclt apply -f deployment.yaml

kubectl get po -o wide

#get the agent (node) name.

docker container ls

#bash -> ubuntu
#sh -> alpine
docker exec -it k3d-k3s-default..-1  /bin/sh

ls k3d/images/pgdata

```

