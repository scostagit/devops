# Make sure you have full Python installation
sudo apt install python3-full

# Create a virtual environment
python3 -m venv dockerenv

# Activate it
source dockerenv/bin/activate

# Upgrade pip inside the venv
pip install --upgrade pip                     

pip install docker

python3 -m pip install docker

python3 index.py


# Quick check**:
# You can verify installation with:

python3 -c "import docker; print(docker.__version__)"


# If this runs without error, the module is installed correctly.
# Would you like me to also show you how to create a `requirements.txt` file so you can avoid this issue in the future?

