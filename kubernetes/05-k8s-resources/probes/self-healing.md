# Self Healing

It is a mechanism that you let kubernetes knows how to fix things.


## Probes

They are kubernetes resources to verify the health of your applications.


Para entender os **Kubernetes Probes**, imagine que você é o gerente de um restaurante. Os "Probes" (Sondas) são as formas que você usa para verificar se seus cozinheiros (os containers) estão bem, se já terminaram de se preparar ou se precisam de um "puxão de orelha" (reiniciar) para voltarem a trabalhar.

Basicamente, o Kubernetes é um sistema que automatiza o gerenciamento de aplicativos. Como ele não consegue "olhar" dentro do código para saber se tudo está funcionando perfeitamente, ele usa essas sondas para fazer perguntas ao aplicativo e decidir o que fazer.

---

### Tipos de Probes no Kubernetes

Aqui está uma tabela simplificada para você entender a função de cada uma:

| Tipo de Probe | O que ela pergunta ao App? | O que acontece se falhar? | Analogia do Restaurante |
| --- | --- | --- | --- |
| **Startup Probe** | "Você já terminou de carregar tudo o que precisa para começar?" | O Kubernetes mata o container e tenta de novo. | O cozinheiro chegando no restaurante e ligando o fogão. Se ele demorar 2 horas, você troca de cozinheiro. |
| **Readiness Probe** | "Você está pronto para receber pedidos dos clientes agora?" | O Kubernetes para de enviar tráfego (clientes) para ele até que ele esteja pronto. | O cozinheiro está na cozinha, mas se ele estiver limpando o chão, ele não pode receber pedidos ainda. |
| **Liveness Probe** | "Você ainda está vivo/acordado ou travou completamente?" | O Kubernetes reinicia o container imediatamente. | Se o cozinheiro desmaiar no meio do serviço, você precisa substituí-lo para a cozinha não parar. |

---

### Por que isso é importante?

Sem essas sondas, o Kubernetes poderia enviar um cliente para um site que ainda está carregando o banco de dados (erro de conexão) ou manteria rodando um aplicativo que travou e não responde mais a ninguém.

**Como funciona na prática:**
O Kubernetes geralmente faz essas verificações de três formas:

1. **HTTP:** Ele tenta acessar um endereço (ex: `seu-site.com/saude`). Se receber um código de "OK", está tudo bem.
2. **TCP:** Ele tenta abrir uma "porta" de conexão com o app.
3. **Exec:** Ele roda um comando dentro do container para ver se ele responde.

Deseja que eu crie um exemplo de código YAML (como os que você enviou nas imagens anteriores) mostrando como configurar uma dessas sondas?

