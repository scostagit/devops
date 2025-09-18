To install Docker Scout on Windows via the command line, follow these steps:

---

### **1. Download the Docker Scout CLI Plugin**

1. **Visit the Releases Page**: Go to the [Docker Scout GitHub releases page](https://github.com/docker/scout-cli/releases) and download the latest `.tar.gz` file for Windows. For example:

   * `docker-scout_1.2.1_windows_amd64.tar.gz`

2. **Extract the Archive**: Use a tool like [7-Zip](https://www.7-zip.org/) to extract the contents of the `.tar.gz` file.

3. **Rename the Binary**: After extraction, rename the binary to `docker-scout.exe`.

---

### **2. Move the Binary to the CLI Plugins Directory**

1. **Create the Directory**: Open PowerShell and run:

   ```powershell
   mkdir -p $env:USERPROFILE\.docker\cli-plugins
   ```

2. **Move the Binary**: Place the `docker-scout.exe` file into the newly created directory:

   ```powershell
   Move-Item -Path "C:\path\to\docker-scout.exe" -Destination "$env:USERPROFILE\.docker\cli-plugins\docker-scout.exe"
   ```

   Replace `"C:\path\to\docker-scout.exe"` with the actual path where you extracted the binary.

---

### **3. Verify the Installation**

1. **Check Docker Version**: Ensure Docker is installed and running:

   ```powershell
   docker --version
   ```

2. **Run Docker Scout**: Test the Docker Scout installation:

   ```powershell
   docker scout --help
   ```

   This should display the available commands and options for Docker Scout.

---

### **Alternative: Install Docker Desktop**

If you prefer an integrated solution, consider installing [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/). Docker Scout is included by default in Docker Desktop starting with version 4.17, providing both GUI and CLI access to its features.

---

For a visual walkthrough, you might find this video helpful:

[How to Add the Docker Scout Feature to the Docker CLI](https://www.youtube.com/watch?v=pb7ydpJq-D8&utm_source=chatgpt.com)

---


## Links Tools

[Assinar a Imgem](https://edu.chainguard.dev/chainguard/chainguard-images/getting-started/node/)

[Vulnerabilidasde Docker Scout](https://scout.docker.com/reports/org/sergiodoc/images?stream=latest-indexed)

[Docker hub](https://hub.docker.com/repository/docker/sergiodoc/projeto-caotico/general)