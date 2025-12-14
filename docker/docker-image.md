# Docker imagge

---

### `FROM node:18.16.0`

👉 **Define a base do container**

* Diz ao Docker:

  > “Quero usar uma imagem que já tenha o **Node.js versão 18.16.0** instalado”.
* Essa imagem vem pronta, com Linux + Node.js configurados.
* É como escolher um computador que já vem com o Node instalado.

---

### `WORKDIR /app`

👉 **Define a pasta de trabalho dentro do container**

* Cria (ou usa) a pasta `/app` dentro do container.
* A partir daqui, **todos os comandos serão executados dentro dessa pasta**.
* É como dar um `cd /app` automático.

---

### `COPY package*.json ./`

👉 **Copia os arquivos de dependências**

* Copia `package.json` e `package-lock.json` (se existir)
  do seu computador **para dentro do container**, na pasta `/app`.
* Isso é feito antes do código inteiro para **aproveitar o cache do Docker** (fica mais rápido nas próximas builds).

---

### `RUN npm install`

👉 **Instala as dependências do projeto**

* Executa o comando `npm install` dentro do container.
* Lê o `package.json` e baixa todas as bibliotecas necessárias.
* Isso acontece **na hora de criar a imagem**, não quando o container roda.

---

### `COPY . .`

👉 **Copia todo o resto do projeto**

* Copia **todos os arquivos do projeto** (server.js, pastas, configs, etc.)
  do seu computador para o container, dentro de `/app`.
* O primeiro `.` é a pasta atual do seu projeto.
* O segundo `.` é a pasta atual do container (`/app`).

---

### `EXPOSE 8080`

👉 **Informa qual porta a aplicação usa**

* Diz ao Docker:

  > “Essa aplicação escuta a porta 8080”.
* **Não abre a porta automaticamente**, apenas documenta.
* A abertura real acontece quando você usa `-p 8080:8080` no `docker run`.

---

### `CMD ["node","server.js"]`

👉 **Define o comando que roda quando o container inicia**

* Quando o container começa, ele executa:

  ```bash
  node server.js
  ```
* É como clicar em “iniciar” a aplicação.
* Deve existir um arquivo `server.js` no projeto.

---

## Resumão em linguagem bem simples 🧠

Esse Dockerfile faz o seguinte:

1. Pega um “computador” com Node.js instalado
2. Entra na pasta `/app`
3. Copia as informações das dependências
4. Instala as dependências
5. Copia o código da aplicação
6. Diz que a app usa a porta 8080
7. Inicia o servidor Node.js


