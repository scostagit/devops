# Configuratin

Where can save the string connections, tokens and access keys?

## Good practises

1 - Environment Variable

### The Twelve-Factor App principles

## Linux

 to check all environment variable:


```bash

env

```


To set the envonriment variable on Liux


```bash

export APP_NAME="Application Lesson 01"
export APP _VERSION=2.0
export APP_AUTHOR="Bozo"

env

```


## Windows

On **Windows 11**, the equivalent commands depend on **which shell you’re using**. Here are the correct ways for the most common ones.

---

## ✅ Option 1: **PowerShell (Recommended on Windows 11)**

```powershell
$env:APP_NAME="Application Lesson 01"
$env:APP_VERSION="2.0"
$env:APP_AUTHOR="Bozo"

Get-ChildItem Env:
```

📌 Notes:

* `$env:VAR="value"` sets an environment variable **for the current session**
* `Get-ChildItem Env:` is the equivalent of `env`

---

## ✅ Option 2: **Command Prompt (cmd.exe)**

```cmd
set APP_NAME=Application Lesson 01
set APP_VERSION=2.0
set APP_AUTHOR=Bozo

set
```

📌 Notes:

* Variables exist **only in the current command window**
* `set` lists all environment variables

---

## ✅ Option 3: **Persistent (System or User) Variables**

If you want the variables to **persist across reboots**:

### PowerShell (User-level)

```powershell
setx APP_NAME "Application Lesson 01"
setx APP_VERSION "2.0"
setx APP_AUTHOR "Bozo"
```

⚠️ Important:

* `setx` **does not affect the current session**
* You must open a new terminal to see the changes

---

## 🧪 Verify the Variables

### PowerShell

```powershell
echo $env:APP_NAME
```

### Command Prompt

```cmd
echo %APP_NAME%
```

---

## ⚠️ Common Mistake (From Your Example)

❌ This will **not work** on Linux or Windows:

```bash
export APP _VERSION=2.0
```

✔ Correct:

```bash
export APP_VERSION=2.0
```

(Space in variable name breaks it.)

---

## 🧠 Kubernetes / Docker Tip (Relevant to 12-Factor Apps)

These map cleanly to container environments:

```yaml
env:
- name: APP_NAME
  value: "Application Lesson 01"
```

---

### Summary

| Shell      | Set Variable       | Show Variables       |
| ---------- | ------------------ | -------------------- |
| PowerShell | `$env:VAR="value"` | `Get-ChildItem Env:` |
| CMD        | `set VAR=value`    | `set`                |
| Persistent | `setx VAR "value"` | New session          |

If you want, I can also show:

* **Docker equivalents**
* **WSL/Linux comparison**
* **Kubernetes examples**
* **How this ties back to 12-Factor config**

Just say the word 👍


# Running environment variable on Windows 11
```powershell

$env:APP_NAME="Application Lesson 01 from windos"
$env:APP_VERSION="3.0"
$env:APP_AUTHOR="Bozo windows"

node server.js

```


[Application Repo](https://github.com/KubeDev/app-variaveis-ambiente)

## Creating a Kubernetes Cluster with k3d

```bash

k3d cluster create mycluster --servers 3 --agents 3 --port "30000:30000@loadbalancer:*" --api-port localhost:6443

kubectl get nodes

NAME                     STATUS   ROLES                       AGE     VERSION
k3d-mycluster-agent-0    Ready    <none>                      3m34s   v1.31.5+k3s1
k3d-mycluster-agent-1    Ready    <none>                      3m34s   v1.31.5+k3s1
k3d-mycluster-agent-2    Ready    <none>                      3m34s   v1.31.5+k3s1
k3d-mycluster-server-0   Ready    control-plane,etcd,master   4m14s   v1.31.5+k3s1
k3d-mycluster-server-1   Ready    control-plane,etcd,master   3m54s   v1.31.5+k3s1
k3d-mycluster-server-2   Ready    control-plane,etcd,master   3m39s   v1.31.5+k3s1

```


## Checking the logs

```bash

kubectl logs app-configuracao-6bd885f4cd-zftm6
Aplicação ouvindo na porta 3000

```

Access the web appliation througth:

```
http://localhost:30000

```


## Accessing the pod terminal

```bash

kubectl get po


kubectl exec -it app-configuracao-7f946d6c59-5htwg -- /bin/bash

root@app-configuracao-7f946d6c59-5htwg:/app#

env

```