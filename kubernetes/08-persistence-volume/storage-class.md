# Volume

It is outside the kubernetes cluster.

# PV

It is an objet that represents a voume. It look likes an interface.

## Manual

You can create via manifest file.

## Dynamic 

There is a service on your cluster or in your cloud provider.

# PV Status

 - **Available** : You can use
 - **Bound** : The volume is linked with  PVC
 - **Released**: Free you to use
 - **Failed**: Something wrong happend.

```

```

[PV, PVC and Volume Documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

# PVC

PODs don't access the volume diractly. It uses a PV.

```
POD -> PVC -> PV -> Volume

```

***IMPORTANT: IF THE PVC DOES NET MATCH WITH THE REQUIEMENTS, YOU POD WON'T HAVE VOLUME***  
***====================================================================================***


Ex.: 


```
Case 01
PV 50GB, PVC: 51GB, no way, you POD won't have any volume linked.

Case 02
PV 52GB, PVC: 51GB, Ok!! Happy Days, you POD is linked to the Volume.


```


***====================================================================================***


# Storage Class

## 📦 O que é **StorageClass** no Kubernetes?

**StorageClass** é o **jeito que o Kubernetes sabe *como criar* um disco**.

👉 Pense assim:

* PVC diz **quanto espaço quer**
* **StorageClass diz *como* esse espaço será criado**

---

## 🏗️ Analogia simples

É como escolher o **tipo de construção** do apartamento:

* padrão
* luxo
* temporário

Cada tipo usa um **material diferente**.

---

## 🔁 Na prática

* Você cria um **PVC**
* O PVC aponta para um **StorageClass**
* O Kubernetes cria o **PV automaticamente**, seguindo aquela regra

---

## 🧠 Resumo em uma frase

> **StorageClass = regra que diz de onde e como o volume será criado**

---

### Mini diagrama mental

```
Pod → PVC → StorageClass → PV → Disco real
```



# Exemplo:

## 🗂️ StorageClass com **NFS**

👉 **O que acontece**

* O NFS **já existe** (um servidor com uma pasta)
* O StorageClass só diz **como conectar** nesse NFS
* Normalmente o PV é **estático** (criado antes)

📌 **Uso comum**

* Vários pods precisam **compartilhar os mesmos arquivos**
* Ex: uploads, imagens, arquivos estáticos

🧠 **Frase simples**

> *“Use esse caminho NFS para criar volumes”*

---

## ☁️ StorageClass na **AWS (EBS)**

👉 **O que acontece**

* O disco **não existe ainda**
* O StorageClass diz:

  * tipo do disco (gp3, io1…)
  * tamanho
  * performance
* Quando o PVC é criado → **a AWS cria o disco automaticamente**

📌 **Uso comum**

* Banco de dados
* Cada pod com seu próprio disco

🧠 **Frase simples**

> *“Quando alguém pedir espaço, crie um disco na AWS desse tipo”*

---

## 🔁 Comparação rápida

```
NFS + StorageClass
- Disco já existe
- Compartilhado
- Criação manual

AWS + StorageClass
- Disco criado na hora
- Individual
- Totalmente automático
```

---

## 🧠 Regra de bolso

* **Arquivos compartilhados** → NFS
* **Dados críticos / banco** → AWS (EBS)

Se quiser, posso mostrar **um YAML mínimo de StorageClass + PVC** para cada caso, bem comentado.

