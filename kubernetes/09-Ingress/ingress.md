# Ingress

Ingress controls

expose the domain for other services to consume.


## Ingress 

rules for my routes to my service inside my cluster.

instead of access a service by public ip, which is very expensive, we can a domain with our ***igress contoller.***


- Ingress controller works like a reverse proxy.
- You can one or many igress controllers in your eco-system.






Below is a **clean text (ASCII) diagram** and an explanation that matches the image and shows **Kubernetes Ingress with 3 Services, each having 3 Pods**, plus **how DNS points to the Ingress Controller**.

---

## 1. High-level Kubernetes Ingress Architecture (Text Diagram)

```
                  ┌──────────────────────────┐
                  │        DNS (Public)       │
                  │  app.example.com          │
                  │  api.example.com          │
                  │  auth.example.com         │
                  └─────────────┬────────────┘
                                │
                                │  A / CNAME Record
                                ▼
                  ┌──────────────────────────┐
                  │   Load Balancer / IP     │
                  │  (Ingress Controller)    │
                  │  e.g. NGINX / Traefik    │
                  └─────────────┬────────────┘
                                │
                                ▼
                  ┌──────────────────────────┐
                  │     Ingress Controller   │
                  │  (runs inside cluster)  │
                  └─────────────┬────────────┘
                                │
                ┌───────────────┼────────────────┐
                │               │                │
                ▼               ▼                ▼
        ┌────────────┐  ┌────────────┐  ┌────────────┐
        │  Service A │  │  Service B │  │  Service C │
        │  (ClusterIP│  │  (ClusterIP│  │  (ClusterIP│
        │   or Node) │  │   or Node) │  │   or Node) │
        └─────┬──────┘  └─────┬──────┘  └─────┬──────┘
              │               │                │
      ┌───────┼───────┐ ┌─────┼──────┐ ┌───────┼───────┐
      ▼       ▼       ▼ ▼     ▼      ▼ ▼       ▼       ▼
   ┌────┐  ┌────┐  ┌────┐ ┌────┐ ┌────┐ ┌────┐  ┌────┐  ┌────┐
   │Pod │  │Pod │  │Pod │ │Pod │ │Pod │ │Pod │  │Pod │  │Pod │
   │ A1 │  │ A2 │  │ A3 │ │ B1 │ │ B2 │ │ B3 │  │ C1 │  │ C2 │  │ C3 │
   └────┘  └────┘  └────┘ └────┘ └────┘ └────┘  └────┘  └────┘  └────┘
```

---

## 2. How Traffic Flows

1. **User requests**

   ```
   https://app.example.com
   ```

2. **DNS resolves**

   ```
   app.example.com → Ingress Controller IP / Load Balancer
   ```

3. **Ingress Controller**

   * Reads Ingress rules
   * Matches **host** or **path**
   * Routes traffic to the correct Service

4. **Service**

   * Load-balances traffic across its Pods

5. **Pods**

   * Handle the request

---

## 3. Example Ingress Rules (Conceptual)

```
Host: app.example.com
  → Service A (port 80)

Host: api.example.com
  → Service B (port 80)

Host: auth.example.com
  → Service C (port 80)
```

OR using paths:

```
example.com/app   → Service A
example.com/api   → Service B
example.com/auth  → Service C
```

---

## 4. DNS → Ingress Controller (How It Works)

### Step 1: Get Ingress Controller Address

Depending on your setup:

* **Cloud (EKS/GKE/AKS)**
  Ingress Controller exposes a **LoadBalancer**

  ```
  EXTERNAL-IP: 35.201.10.25
  ```

* **On-prem / bare metal**

  * MetalLB IP
  * Or Node IP + reverse proxy (like your drawing)

---

### Step 2: Create DNS Records

#### Option A: Using an IP (A Record)

```
app.example.com    → 35.201.10.25
api.example.com    → 35.201.10.25
auth.example.com   → 35.201.10.25
```

#### Option B: Using a Load Balancer hostname (CNAME)

```
app.example.com    → ingress-lb.cloudprovider.com
api.example.com    → ingress-lb.cloudprovider.com
auth.example.com   → ingress-lb.cloudprovider.com
```

➡️ **All domains point to the same Ingress Controller**, which then routes internally.

---

## 5. Mapping This to Your Drawing

Your image represents:

* **External DNS**
* **Reverse Proxy / Load Balancer**
* **Ingress Controller**
* **Multiple Services**
* **Multiple Pods per Service**

Key idea:

> DNS never points to Pods or Services directly — it always points to the **Ingress Controller endpoint**.

---

## 6. Simple Mental Model

```
DNS → Ingress Controller → Service → Pod
```

Ingress is the **traffic director**, Services are the **load balancers**, and Pods are the **workers**.






## 🧠 Ideia principal (bem direta)

**Ingress é a “porta de entrada” do Kubernetes para a internet.**

Ele decide:

* **quem entra**
* **para onde vai**
* **qual serviço recebe a requisição**



## 🏠 Comparação com algo do dia a dia

Imagine um **prédio comercial**:

* 🧍 Pessoas = usuários da internet
* 🌐 Endereço do prédio = domínio (ex: `meusite.com`)
* 🚪 Portaria = **Ingress**
* 🏢 Salas = **Services**
* 👨‍💻 Funcionários = **Pods**

### Fluxo:

```
Pessoa → Portaria → Sala correta → Funcionário
```


## 🌐 Sem Ingress (jeito ruim)

Sem Ingress, cada aplicação precisa de um IP próprio:

```
App A → IP 1
App B → IP 2
App C → IP 3
```

❌ Problemas:

* Muitos IPs
* Difícil de manter
* Caro em cloud



## ✅ Com Ingress (jeito certo)

Com Ingress, você tem **um único ponto de entrada**:

```
meusite.com
api.meusite.com
auth.meusite.com
```

Tudo entra pelo **Ingress**, que decide o destino.

## 🔀 O que o Ingress faz exatamente?

Ele olha:

* o **domínio** (host)
* ou o **caminho** (path)

E encaminha para o serviço correto.

### Exemplo simples:

```
meusite.com        → site
api.meusite.com    → api
meusite.com/login  → auth
```



## 🧩 Peças importantes (sem complicação)

### 1️⃣ Pod

É onde sua aplicação roda.

```
Pod = app rodando
```


### 2️⃣ Service

É quem **distribui tráfego** entre vários pods.

```
Service → Pod 1
        → Pod 2
        → Pod 3
```



### 3️⃣ Ingress Controller (o mais importante)

É o **software que realmente recebe o tráfego**.

Exemplos:

* NGINX
* Traefik
* HAProxy

> ⚠️ Sem Ingress Controller, o Ingress não funciona.


### 4️⃣ Ingress (regra)

É só um **arquivo de regras**, tipo:

> “Se vier desse endereço, manda pra esse serviço”



## 🧾 Exemplo humano de regra de Ingress

> “Se alguém acessar `site.com`, mande para o Service do site”

> “Se acessar `api.site.com`, mande para o Service da API”



## 🌍 Onde entra o DNS?

O **DNS só aponta para o Ingress Controller**, nunca para os pods.

```
site.com → IP do Ingress Controller
```

Depois disso:

* o Ingress decide tudo lá dentro



## 🔐 HTTPS (bônus simples)

O Ingress também:

* cuida do HTTPS
* instala certificados
* força redirecionamento HTTP → HTTPS

Tudo em **um lugar só** 👍



## 🧠 Frase para guardar

> **Ingress é o porteiro do Kubernetes.**
> Ele recebe todas as visitas e decide para qual serviço elas vão.



## 📌 Resumo em uma linha

```
Internet → DNS → Ingress Controller → Service → Pods
```

## Ingress vs LoadBalancer and Ingress x API Gateway


Perfeito 👍
Vou explicar **bem didático**, passo a passo, do jeito mais simples possível.



# 1️⃣ Ingress explicado com **desenho ASCII**

### 🌐 Visão geral

```
Usuário (Internet)
        |
        v
   site.com / api.site.com
        |
        v
      [ DNS ]
        |
        v
+---------------------------+
|   Ingress Controller      |  ← (NGINX / Traefik)
|   "porteiro do cluster"   |
+-------------+-------------+
              |
     +--------+--------+
     |                 |
     v                 v
+---------+       +---------+
| Service |       | Service |
|  Site   |       |  API    |
+----+----+       +----+----+
     |                 |
  +--+--+          +---+---+
  | Pod |          |  Pod  |
  | Pod |          |  Pod  |
  | Pod |          |  Pod  |
```

👉 Tudo entra por **um único lugar** (Ingress).



### 🌐 Usando caminhos (path)

```
site.com/        → frontend
site.com/api     → backend
site.com/auth    → auth
```

```
              +-------------------+
site.com ---> |     Ingress       |
              | /      → frontend |
              | /api   → backend  |
              | /auth  → auth     |
              +---------+---------+
                        |
                 +------+------+
                 |   Services  |
```



# 2️⃣ Ingress vs LoadBalancer (bem simples)

## 🧠 Analogia rápida

* **LoadBalancer** = portão exclusivo por app
* **Ingress** = portaria inteligente compartilhada



## 🔹 LoadBalancer

```
Internet
   |
   v
[ LoadBalancer ]  → App A
```

Se tiver 3 apps:

```
LB A → App A
LB B → App B
LB C → App C
```

### ❌ Problemas

* Muitos IPs
* Mais caro
* Pouco controle
* Difícil HTTPS centralizado



## 🔹 Ingress

```
Internet
   |
   v
[ LoadBalancer ]
      |
      v
[ Ingress Controller ]
      |
+-----+-----+-----+
|  App A   App B  App C
```

### ✅ Vantagens

* 1 IP só
* HTTPS centralizado
* Regras por domínio/caminho
* Escala melhor


## 📊 Comparação direta

| Item       | LoadBalancer | Ingress      |
| ---------- | ------------ | ------------ |
| IP público | 1 por app    | 1 para tudo  |
| Custo      | Alto         | Baixo        |
| HTTPS      | Individual   | Centralizado |
| Roteamento | Simples      | Avançado     |
| Escala     | Limitada     | Alta         |

👉 **Ingress usa LoadBalancer por baixo**, mas de forma inteligente.



# 3️⃣ Ingress x API Gateway (sem confusão)

Essa comparação confunde muita gente — então vamos simplificar.



## 🔹 Ingress (porteiro)

* Roteia tráfego
* Termina HTTPS
* Funciona na camada HTTP
* Simples e rápido

```
Ingress = "manda pra lá"
```



## 🔹 API Gateway (gerente)

Além de rotear, ele:

* Autentica usuários
* Aplica rate limit
* Valida tokens
* Transforma requests
* Versiona APIs

```
API Gateway = "quem pode entrar e como"
```


## 🧠 Analogia perfeita

### Ingress

> Porteiro do prédio
> “Você vai para essa sala”

### API Gateway

> Segurança + recepção + gerente
> “Quem é você? Pode entrar? Quantas vezes?”



## 📊 Comparação direta

| Função               | Ingress      | API Gateway |
| -------------------- | ------------ | ----------- |
| Roteamento           | ✅            | ✅           |
| HTTPS                | ✅            | ✅           |
| Autenticação         | ❌            | ✅           |
| Rate limit           | ❌ (limitado) | ✅           |
| Transformar requests | ❌            | ✅           |
| Observabilidade      | Básica       | Avançada    |



## 🧩 Como eles trabalham juntos (mundo real)

```
Internet
   |
   v
Ingress
   |
   v
API Gateway
   |
   v
Services / Pods
```

👉 **Ingress recebe o tráfego**
👉 **API Gateway governa as regras da API**



## 🧠 Resumo fácil de decorar

```
LoadBalancer → infraestrutura
Ingress      → roteamento
API Gateway  → regras de negócio da API
```



## 🧠 Frase final (pra nunca esquecer)

> **Ingress organiza o trânsito.
> API Gateway aplica as leis.**





## IP endereco de Looping Back

O **endereço de loopback** é um endereço IP especial usado para permitir que um computador se comunique consigo mesmo.

Em termos simples, ele funciona como um "espelho virtual": quando você envia dados para esse endereço, eles não saem para a rede física (cabo ou Wi-Fi); em vez disso, o sistema operacional os intercepta e os devolve imediatamente para a própria máquina.

Aqui estão os detalhes fundamentais:

### 1. O Endereço Padrão

* **IPv4:** O endereço mais comum é o **127.0.0.1**. Na verdade, toda a faixa de `127.0.0.0` a `127.255.255.255` é reservada para loopback.
* **IPv6:** O equivalente é escrito como **::1**.
* **Nome de Host:** Quase sempre é associado ao nome **localhost**.

---

### 2. Para que serve?

O loopback é uma ferramenta essencial para desenvolvedores e administradores de sistemas por três motivos principais:

* **Testes Locais:** Permite rodar um servidor (como um site ou banco de dados) no seu próprio computador e acessá-lo pelo navegador sem precisar de internet.
* **Verificação da Placa de Rede:** Ao dar um comando "ping" para o 127.0.0.1, você confirma se a pilha de protocolos TCP/IP do seu sistema operacional está instalada e funcionando corretamente.
* **Comunicação entre Processos:** Softwares diferentes rodando na mesma máquina podem usar o endereço de loopback para trocar dados entre si.

---

### 3. Como ele se relaciona com a imagem que você enviou?

A imagem que você carregou mostra o caminho do arquivo **hosts**. Esse arquivo é frequentemente usado para "direcionar" nomes de sites para o endereço de loopback.

Por exemplo, se você adicionar a linha `127.0.0.1 facebook.com` no seu arquivo hosts, toda vez que você tentar acessar o Facebook, seu computador tentará se conectar a **ele mesmo** em vez de ir para a internet, servindo como uma forma simples de bloquear sites.

> **Curiosidade:** O termo "Loopback" vem do inglês *loop* (laço) e *back* (de volta), indicando que a informação faz um retorno imediato à origem.

Você gostaria de saber como realizar um teste de ping no seu endereço de loopback para verificar se sua conexão interna está ok?

[Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)