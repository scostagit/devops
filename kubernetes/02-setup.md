
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