# POD Life Cycle

Here is the **Pod life cycle in Kubernetes**, explained in **very simple English**, with a **text diagram**.

---

## Pod Life Cycle (Very Simple)

A **Pod** is the smallest thing Kubernetes runs.

### 1. Pod is Created

* You ask Kubernetes to run a Pod.
* Kubernetes writes the Pod in its system.

---

### 2. Pod is Scheduled

* Kubernetes chooses a **node (machine)** for the Pod.
* The Pod is sent to that node.

---

### 3. Pod is Starting

* The node downloads container images.
* Containers inside the Pod start running.

---

### 4. Pod is Running

* All containers are running.
* The Pod is doing its work.

---

### 5. Pod Can Stop or Fail

A Pod may stop because:

* The app finished its job
* There was an error
* The Pod was deleted
* The node crashed

---

### 6. Pod Ends (Terminated)

* Containers stop.
* Pod is removed.
* Pod **will not restart** unless something (like a Deployment) creates a new one.

---

## Pod Status (Simple)

* **Pending** → waiting to run
* **Running** → working
* **Succeeded** → finished successfully
* **Failed** → finished with error
* **Unknown** → node not responding

---

## Text Diagram (Simple)

```
[ Pod Created ]
       |
       v
[   Pending   ]
       |
       v
[  Scheduled  ]
       |
       v
[  Starting   ]
       |
       v
[   Running   ]
       |
       v
+---------------+
| Finish / Fail |
+---------------+
       |
       v
[ Terminated ]
```

---

## Very Short Summary

* Pod is created
* Pod runs
* Pod stops
* Pod is gone

Below is everything you asked for, explained in **very simple English**, with **clear examples** and **small diagrams**.

---

# 1️⃣ Pod vs Container (Very Simple)

### Container

* A **container** runs **one app**
* Example: a Python app, Java app, Nginx

### Pod

* A **Pod** holds **one or more containers**
* Containers in a Pod:

  * Share **IP address**
  * Share **storage**
  * Always run **together**

### Simple Rule

> **Kubernetes runs Pods, not containers**

### Example

* 1 Pod

  * 1 Nginx container
  * 1 helper container (logs)

```
Pod
 ├─ Container: Nginx
 └─ Container: Log helper
```

---

# 2️⃣ Restart Policies (Simple)

Restart policy tells Kubernetes **what to do if a container stops**.

### Types of Restart Policies

| Policy        | What happens                 |
| ------------- | ---------------------------- |
| **Always**    | Restart every time (default) |
| **OnFailure** | Restart only if error        |
| **Never**     | Never restart                |

### Examples

* **Web app** → `Always`
* **Batch job** → `OnFailure`
* **One-time task** → `Never`

```
Container stops
      |
      v
Restart? → Depends on policy
```

---

# 3️⃣ Pod Life Cycle with Deployments (Very Important)

A **Deployment** manages Pods for you.

### Key Idea

> **If a Pod dies, Deployment creates a new Pod**

### What Really Happens

1. You create a Deployment
2. Deployment creates Pods
3. Pod crashes or is deleted
4. Deployment makes a **new Pod**

⚠️ The old Pod is **not restarted**
✅ A **new Pod** is created

### Diagram

```
Deployment
     |
     v
   Pod A (dies)
     X
     |
     v
   Pod B (new)
```

### Important

* Pod names change
* Pod IP changes
* Deployment stays the same

---

# 4️⃣ Pod States with Real Examples

### 1. Pending

**Meaning:** Pod is waiting

**Example:**

* No free node
* Image still downloading

```
kubectl get pods
STATUS: Pending
```

---

### 2. Running

**Meaning:** Pod is working

**Example:**

* Web server is serving users

```
STATUS: Running
```

---

### 3. Succeeded

**Meaning:** Pod finished successfully

**Example:**

* Backup job finished

```
STATUS: Succeeded
```

---

### 4. Failed

**Meaning:** Pod finished with error

**Example:**

* App crashed
* Wrong command

```
STATUS: Failed
```

---

### 5. CrashLoopBackOff (Very Common)

**Meaning:** Pod keeps crashing and restarting

**Example:**

* App starts → crashes → restarts → crashes

```
STATUS: CrashLoopBackOff
```

---

### 6. Unknown

**Meaning:** Kubernetes cannot reach the node

**Example:**

* Node network problem

```
STATUS: Unknown
```

---

# 🔁 Full Simple Pod Flow (With Deployment)

```
User creates Deployment
          |
          v
      Pod Created
          |
      Running
          |
     Pod crashes
          |
Deployment creates new Pod
          |
      Running again
```

---

## 🧠 Easy Memory Tips

* **Pod = wrapper**
* **Container = app**
* **Deployment = Pod manager**
* **Pods die, Deployments don’t**

