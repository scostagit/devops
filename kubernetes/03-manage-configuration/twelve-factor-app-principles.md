# The Twelve-Factor App principles

The **12 principles** you’re referring to are most commonly known as **The Twelve-Factor App** principles. They aren’t *exclusively* for microservices, but they are **widely adopted as best practices for building cloud-native and microservices-based systems**.

Here’s a clear, concise breakdown 👇

---

## The 12 Microservices / Twelve-Factor App Principles

### 1. **Codebase**

* One codebase tracked in version control
* Multiple deployments (dev, staging, prod) from the same codebase

---

### 2. **Dependencies**

* Explicitly declare and isolate dependencies
* No reliance on system-wide packages
* Use dependency managers (e.g., Maven, npm, pip)

---

### 3. **Config**

* Store configuration in the environment
* No config hard-coded in the app
* Examples: DB URLs, API keys, feature flags

---

### 4. **Backing Services**

* Treat backing services as attached resources
* Examples: databases, message queues, caches
* Can be swapped without code changes

---

### 5. **Build, Release, Run**

* Strict separation between:

  * **Build** (compile/package)
  * **Release** (config + build)
  * **Run** (execution)
* Enables reliable rollbacks

---

### 6. **Processes**

* Execute the app as stateless processes
* No local file or memory persistence
* State stored in backing services

---

### 7. **Port Binding**

* Services expose functionality via ports
* Self-contained (e.g., embedded web servers)
* No dependency on external web servers

---

### 8. **Concurrency**

* Scale by running multiple instances
* Horizontal scaling rather than vertical scaling
* Supports elastic scaling

---

### 9. **Disposability**

* Fast startup and graceful shutdown
* Enables rapid scaling and resilient deployments
* Important for container orchestration (e.g., Kubernetes)

---

### 10. **Dev/Prod Parity**

* Keep development, staging, and production as similar as possible
* Minimize “works on my machine” issues

---

### 11. **Logs**

* Treat logs as event streams
* Write logs to stdout/stderr
* Let the platform aggregate and manage them

---

### 12. **Admin Processes**

* Run admin/management tasks as one-off processes
* Same codebase and environment
* Examples: DB migrations, batch jobs

---

## Why These Matter for Microservices

They enable:

* Independent deployment
* Scalability and resilience
* Cloud portability
* Container & Kubernetes friendliness
* Faster CI/CD pipelines

---

### Related (Often Confused) Concepts

If you’re exploring microservices, you may also want:

* **Microservices Design Principles** (single responsibility, autonomy)
* **Domain-Driven Design (DDD)**
* **Resilience patterns** (circuit breakers, retries)
* **Observability principles**

Great choice — this is where the **12-Factor principles really come alive** in real systems 🚀
I’ll cover all three parts clearly and practically.

---

# 1️⃣ Mapping the 12 Principles to **Kubernetes**

| 12-Factor Principle     | How Kubernetes Supports It                                  |
| ----------------------- | ----------------------------------------------------------- |
| **Codebase**            | One Git repo → multiple deployments via different manifests |
| **Dependencies**        | Container images package all dependencies                   |
| **Config**              | `ConfigMaps`, `Secrets`, environment variables              |
| **Backing Services**    | External DBs, caches, queues via Service URLs               |
| **Build, Release, Run** | CI builds image → CD deploys image + config                 |
| **Processes**           | Pods are ephemeral & stateless                              |
| **Port Binding**        | Containers expose ports; Services route traffic             |
| **Concurrency**         | Horizontal Pod Autoscaler (HPA)                             |
| **Disposability**       | Fast pod startup + graceful shutdown hooks                  |
| **Dev/Prod Parity**     | Same image in all environments                              |
| **Logs**                | `stdout/stderr` collected by logging stack                  |
| **Admin Processes**     | `Jobs`, `CronJobs`, `kubectl exec`                          |

---

# 2️⃣ **Real-World Examples** (Microservices Context)

### Example: **Order Service**

### 🔹 Config

```yaml
env:
- name: DB_URL
  valueFrom:
    secretKeyRef:
      name: order-db-secret
      key: url
```

➡ Same image works in dev, staging, prod.

---

### 🔹 Stateless Processes

❌ Bad:

```java
static Map<String, Order> cache = new HashMap<>();
```

✅ Good:

```java
Redis / PostgreSQL used for state
```

---

### 🔹 Logs

```bash
logger.info("Order created: {}", orderId);
```

➡ Collected by ELK / Loki / CloudWatch.

---

### 🔹 Disposability

```yaml
lifecycle:
  preStop:
    exec:
      command: ["sleep", "10"]
```

➡ Allows in-flight requests to finish before shutdown.

---

### 🔹 Concurrency

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
```

➡ Scale pods when traffic spikes.

---

# 3️⃣ 12-Factor vs **Microservices-Specific Principles**

### ⚠️ Important:

> **12-Factor ≠ Microservices architecture**
> It supports microservices but doesn’t define them.

---

## 🔹 What 12-Factor Covers Well

✔ Deployment
✔ Configuration
✔ Scaling
✔ Cloud readiness
✔ Operational consistency

---

## 🔹 What 12-Factor Does NOT Cover

| Missing Area       | Microservices Principle   |
| ------------------ | ------------------------- |
| Service boundaries | **Single Responsibility** |
| Data ownership     | **Database per Service**  |
| Communication      | **API contracts**         |
| Failure handling   | **Resilience patterns**   |
| Team ownership     | **Conway’s Law**          |
| Discovery          | **Service Discovery**     |

---

## 🧠 Core **Microservices-Specific Principles**

### 1. **Single Responsibility**

Each service does *one thing well*.

---

### 2. **Autonomy**

Services deploy and scale independently.

---

### 3. **Decentralized Data**

Each service owns its own database.

---

### 4. **Resilience by Design**

* Circuit breakers
* Retries
* Timeouts
* Bulkheads

---

### 5. **API-First Communication**

* REST / gRPC / Events
* Backward-compatible changes

---

### 6. **Observability**

* Metrics (Prometheus)
* Logs
* Distributed tracing (Jaeger)

---

### 7. **Event-Driven Architecture (Optional)**

* Kafka / RabbitMQ
* Loose coupling
* Eventual consistency

---

# 🧩 Summary Table

| Area              | 12-Factor        | Microservices Principles |
| ----------------- | ---------------- | ------------------------ |
| Scope             | Application      | Architecture             |
| Focus             | Deployment & ops | Design & boundaries      |
| Stateless         | ✅                | ✅                        |
| Config            | ✅                | ⚠️ partial               |
| Data ownership    | ❌                | ✅                        |
| Resilience        | ❌                | ✅                        |
| Service contracts | ❌                | ✅                        |

---

## 🎯 Final Takeaway

> **Use 12-Factor to build *deployable services***
> **Use Microservices principles to build *correct systems***


