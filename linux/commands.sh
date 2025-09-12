#!/bin/bash
# ============================================
# Linux Command Cheatsheet with Explanations
# ============================================

# --- System Information Commands ---
uname            # Gets name of OS and the kernel
uname -s         # Gets the kernel name
uname -n         # Gets the machine name (hostname)
uname -r         # Gets the kernel release
uname -v         # Gets the Linux version
uname -m         # Gets the name of the hardware
uname -p         # Gets the processor name
uname -i         # Gets the platform name
uname -a         # Displays all the above information at once

# --- Terminal Management ---
clear            # Clears the terminal screen

# --- User & Permissions ---
sudo uname       # Runs uname command as superuser
sudo su          # Switch to root (admin) user
exit             # Exit root/admin session

# --- User Info ---
who              # Displays who is logged in

# --- Memory Info ---
free             # Shows memory usage (used/free memory)

# --- Shutdown & Restart ---
shutdown         # Shuts down the machine
shutdown -r now  # Restarts the machine immediately

# --- Manual / Help ---
man              # Opens the manual/help command
man sudo         # Shows manual for sudo command
man clear        # Shows manual for clear command

# --- File System Navigation ---
pwd              # Prints the current working directory
cd               # Change directory (use with a path)
ls               # List files and folders
ls -a            # List including hidden files/folders
ls -l            # List with detailed information
ls -la           # Detailed list including hidden files

# --- Directory Management ---
mkdir test       # Creates a new directory named test
mkdir -p /root/test/main  # Creates subdirectories recursively

# --- File Management ---
rm -rf [path]    # Remove files/directories recursively & forcefully
cp file.txt /root/file.txt   # Copy file to destination
mv file.txt /root/file.txt   # Move file (cut + paste)
mv oldname.txt newname.txt   # Rename file
touch error.txt  # Create or update file timestamp

# --- File Viewing ---
cat error.txt    # Display entire content of file
head error.txt   # Display top of file
tail error.txt   # Display end of file
tail -n 2 error.txt  # Display last 2 lines of file
more error.txt   # View file with pagination (scroll)
less error.txt   # Similar to more, but more flexible

# --- Searching with Grep ---
grep Error error.txt           # Search for "Error" in file
grep -n Error error.txt        # Same as above, show line numbers
grep -n -i Error error.txt     # Same as above, case-insensitive

# --- Linux Output Redirection ---
# stdout → standard output
# stderr → standard error
# stdin  → standard input (what you type)

# Modify Output:
ls -l | grep error             # Pipe: filter ls output to only show lines with "error"
ls > saida.txt                 # Redirect output to file (overwrite)
ls -l >> saida.txt             # Append output to file
mkdir kubedev/test 2> error.txt  # Redirect error output to file

# --- Device Management ---
mount             # Mount a device
umount            # Unmount (detach) a device




# ============================================
# Package Management and Process Management
# ============================================

# --- Package Management (Debian/Ubuntu-based systems) ---
sudo apt update                     # Updates the package list
sudo apt search nodejs              # Searches for 'nodejs' package in repositories
sudo apt search nodejs | grep nodejs # Filters search results to show only lines containing 'nodejs'
sudo apt install nodejs             # Installs nodejs package
sudo apt remove nodejs              # Uninstalls nodejs package

# --- Process Management ---
ps                                 # Lists all processes running in the current shell
ps -x                              # Lists all processes created by the current user
ps -a                              # Lists all processes created by other users (attached to terminals)
ps -ax                             # Lists all processes, including those not attached to a terminal
ps -aux                            # Lists all processes with detailed info (including user who started them)



# ============================================
# Process Management, SSH Keys, and Sudo Management
# ============================================

# --- Killing Processes ---
kill [PID]       # Kill a process by its PID (Process ID)
kill 5198        # Example: kills process with PID 5198

# --- Process Monitoring ---
top              # Task manager: shows running processes in real-time
htop             # Beautiful/interactive task manager (better version of top)

# --- SSH Key Generation ---
ssh-keygen -t rsa -b 2048   # Generate SSH key pair (RSA, 2048 bits)
# -t rsa specifies RSA algorithm
# -b 2048 specifies key length (2048 bits is recommended)

ls ~/.ssh/       # List SSH keys and config files in your .ssh directory
# id_rsa is your private key (KEEP IT SAFE!)
# id_rsa.pub is your public key (can be shared)

# --- Sudo / Admin User Management ---
sudo usermod -aG sudo [your_username]  # Add your user to the sudo group (give admin rights)
su -             # Log in as root/admin user
exit             # Exit admin/root shell

# --- Extra Tip ---
# To make the terminal full screen:
# - On most Linux terminals: press F11
# - Or go to your terminal's View menu > Fullscreen
