
# Kubeadm

Ótima pergunta — o nome **parece estranho mesmo** 🙂

### 👉 O que significa “Bare Metal”?

**Bare Metal**, em inglês, significa literalmente:

> **“metal nu”** ou **“metal cru”**

---

### 🧠 Por que esse nome foi escolhido?

Porque a ideia é:

👉 **O sistema operacional roda direto no hardware**,
👉 **sem nada no meio** (sem virtualização, sem camadas extras).

Ou seja, o software está em contato **direto com o “metal” da máquina** (processador, memória, disco).

---

### 📦 Comparação simples

#### 🖥️ Bare Metal

* Hardware físico
* Sistema operacional instalado direto nele
* Nenhum “computador falso” no meio

🧠 **Analogia:**
Dirigir um carro **direto**, sem piloto automático, sem intermediários.

---

#### 💻 Máquina Virtual (para comparar)

* Hardware físico
* Um programa que cria máquinas virtuais (ex: VMware)
* Dentro dele, vários sistemas operacionais

🧠 **Analogia:**
Jogar videogame em um **emulador** em vez do console original.

---

### 🔧 Por que as empresas usam Bare Metal?

* ⚡ Mais desempenho
* 🔒 Mais controle
* ⏱️ Menos atraso (latência)
* 📉 Menos complexidade

Por isso, **Bare Metal é muito usado** em:

* Bancos
* Grandes sistemas
* Kubernetes de alta performance
* Servidores críticos

---

### 🧩 Resumo bem direto

> **Bare Metal = servidor físico rodando o sistema operacional direto no hardware, “no metal nu”.**


## LXD 

Claro 🙂 vou explicar **bem do zero**, sem termos técnicos complicados.

---

## 👉 O que é LXD?

**LXD** é um sistema que permite criar e gerenciar **containers**.

Mas vamos por partes 👇

---

## 1️⃣ Primeiro: o que é um container?

Um **container** é como um **computador isolado**, mas **bem mais leve** que uma máquina virtual.

* Parece um computador próprio
* Tem seus próprios programas
* Mas **não precisa de um computador inteiro só para ele**

🧠 **Analogia simples:**
Imagine um prédio grande (o computador/servidor).
Os **containers são quartos** dentro desse prédio:

* Cada quarto é separado
* Cada pessoa acha que tem seu espaço
* Mas todos compartilham a mesma estrutura do prédio

---

## 2️⃣ Onde entra o LXD?

👉 **LXD é o “gerente” desses quartos (containers).**

Ele é o software que:

* Cria containers
* Liga e desliga containers
* Controla memória, CPU, rede, disco
* Mantém tudo organizado

🧠 **Analogia:**
LXD é o **síndico do prédio**:

* Decide quantos quartos existem
* Controla quem entra e sai
* Garante que um quarto não atrapalhe o outro

---

## 3️⃣ LXD é Docker?

❌ Não, mas são parecidos.

* **Docker** → mais focado em rodar **aplicações**
* **LXD** → mais focado em rodar **sistemas completos**

👉 Com LXD, um container pode parecer um **Linux inteiro**, quase como uma máquina virtual, só que:

* Muito mais rápido
* Usa menos recursos

---

## 4️⃣ Por que usar LXD?

Pessoas usam LXD quando querem:

* Criar vários ambientes Linux rapidamente
* Testar coisas sem quebrar o computador principal
* Rodar serviços separados e organizados
* Economizar memória e processamento

📌 Muito comum em:

* Laboratórios
* Ambientes de teste
* Servidores on-premise
* Quem está aprendendo Kubernetes / Linux

---

## 5️⃣ Exemplo do mundo real

Imagine que você quer:

* Um servidor para site
* Outro para banco de dados
* Outro para testes

Com LXD:

* Cada um fica em um **container separado**
* Se um quebrar, os outros continuam funcionando
* Tudo no mesmo computador físico

---

## 🧩 Resumo

> **LXD é uma ferramenta que cria “mini computadores” (containers) dentro de um computador maior, de forma leve, rápida e organizada.**

Se quiser, posso explicar:

* Diferença entre **LXD, Docker e máquina virtual**
* Como o **LXD se relaciona com Kubernetes**
* Um exemplo prático de uso no dia a dia

## Tools

There are some tools that helps you to manage many different ssh terminals at the same time.

**Putty** for windows

**Tilix** for linux

**MobaXTerm** for both [Download here](https://mobaxterm.mobatek.net/download-home-edition.html)

[Tutorial](https://highfalutin-vulture-304.notion.site/Instala-o-com-Kubeadm-8ce4f709872342ff848a4df77e53618d)

[Digital Ocean Dashboard](https://cloud.digitalocean.com/projects/f498acdb-8cf6-4f11-97f1-56fee1e4d322/resources?i=22e605)

[kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

[kubeadm - Creating a cluser](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)