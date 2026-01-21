# Other ways to deploy

We have used only the deployment way, but there are other may ways to deploy pods on kubernetes. Let's
take a look on them.

Imagine o Kubernetes como um **maestro de uma orquestra**. Nem todo músico toca da mesma forma: alguns tocam o tempo todo, outros só entram em uma parte específica e outros só aparecem para um ensaio rápido.

Aqui estão as outras formas de "escalar" esses músicos (containers) além do Deployment padrão:

---

### 1. StatefulSet (O "Organizado")

Diferente do Deployment (onde os Pods são substituídos como se fossem "gado", sem nome fixo), o **StatefulSet** trata cada Pod como um "animal de estimação".

* **O que faz:** Dá um nome fixo e permanente para cada Pod (ex: `banco-0`, `banco-1`).
* **Para que serve:** Bancos de dados. Se o Pod morre e volta, ele mantém a mesma identidade e o mesmo "disco" de arquivos.

### 2. DaemonSet (O "Vigilante")

Enquanto em outros modelos você escolhe quantos Pods quer, aqui a regra é geográfica.

* **O que faz:** Garante que **uma cópia** do container rode em **todos** os nós (máquinas) do seu cluster.
* **Para que serve:** Coleta de logs, monitoramento de hardware ou antivírus. Se você adicionar uma máquina nova ao cluster, o DaemonSet pula nela automaticamente.

### 3. Job (O "Tarefa Única")

Um Deployment tenta manter o container rodando para sempre. O Job é o oposto.

* **O que faz:** Roda um container para realizar uma tarefa específica e, assim que ela termina com sucesso, o container é desligado.
* **Para que serve:** Migração de banco de dados, gerar um relatório pesado ou enviar um e-mail de boas-vindas.

### 4. CronJob (O "Despertador")

É exatamente como um Job, mas com data e hora marcadas.

* **O que faz:** Executa tarefas baseadas em um cronograma (ex: "toda segunda-feira às 3h da manhã").
* **Para que serve:** Backups diários ou limpeza semanal de arquivos temporários.

### 5. Headless Service (O "Telefonista Direto")

Um Service comum funciona como um "balcão de atendimento" que esconde quem está lá atrás. O **Headless Service** tira esse balcão.

* **O que faz:** Em vez de dar um IP único para o grupo, ele permite que você veja o endereço IP direto de cada Pod individualmente.
* **Para que serve:** Muito usado com o **StatefulSet**. Permite que os Pods de um banco de dados conversem entre si diretamente para sincronizar dados, sem intermediários.

---

### Resumo Visual

| Tipo | Comportamento Principal | Analogia |
| --- | --- | --- |
| **StatefulSet** | Ordem e identidade fixa | Alunos com cadeiras marcadas |
| **DaemonSet** | Um em cada máquina | Um porteiro em cada prédio |
| **Job** | Faz e morre | Um eletricista que faz o conserto e vai embora |
| **CronJob** | Tarefa agendada | O caminhão de lixo que passa às 8h |
| **Headless** | Conexão direta | Ramal direto para a mesa de cada funcionário |

