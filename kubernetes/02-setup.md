
# Kubernetes Setup

- pre requirements
You must have the docker installed

## Windows

The packag  chocolatey

You can install **Chocolatey** (a popular Windows package manager) directly from the command line by following these steps:

---

### **Step 1: Open PowerShell as Administrator**

1. Press **Win + X**, then select **Windows PowerShell (Admin)** (or **Terminal (Admin)** on Windows 11).
2. Confirm the UAC prompt.

---



### **Step 2: Run the Installation Command**

In the PowerShell window, paste the following command and press **Enter**:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

This does three things:

* Temporarily bypasses PowerShell's script execution policy.
* Ensures TLS 1.2 is used (required for secure download).
* Downloads and runs Chocolatey's install script.

---




### **Step 3: Verify Installation**

After installation, close PowerShell and open a new **Command Prompt** or **PowerShell** window. Run:

```powershell
choco --version
```

You should see the installed version number (e.g., `1.x.x`).

---

Would you like me to also include instructions for installing it **completely offline** (using the `.nupkg` file)? This can be useful for air-gapped systems.



## kubectl

Got it — you want to install **kubectl** (the Kubernetes command-line tool) on Windows via the command line. Here's how you can do it step by step:

---

## **Option 1: Install kubectl with Chocolatey (Recommended)**

If you already have **Chocolatey** installed, this is the easiest way:

1. Open **PowerShell as Administrator**.
2. Run:

```powershell
choco install kubernetes-cli -y
```

3. After installation, verify it:

```powershell
kubectl version --client
```

This will show the installed kubectl client version.

---