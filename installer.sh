#!/bin/bash

# Check if the script is running on a Debian-based system
if [ "$(uname -s)" != "Linux" ] || [ ! -f /etc/debian_version ]; then
  echo "This script is intended for Debian-based systems only."
  exit 1
fi

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

MC_USER="minecraft"
PAPER_VERSION="1.20.4"
BUILD_NUMBER="378"
PAPER_URL="https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${BUILD_NUMBER}/downloads/paper-${PAPER_VERSION}-${BUILD_NUMBER}.jar"
SERVICE_FILE="/lib/systemd/system/minecraft.service"

# Check if Minecraft user exists
if id "$MC_USER" >/dev/null 2>&1; then
  echo "User $MC_USER already exists. Skipping user creation."
else
  echo "Creating Minecraft User"
  useradd -m -s /bin/bash "$MC_USER"
  usermod -aG "$MC_USER" "$MC_USER"
fi

# Check if Java is installed
if command -v java &>/dev/null; then
  echo "Java is already installed. Skipping Java installation."
else
  echo "Updating System & Installing Java"
  sudo apt update
  sudo apt install -y openjdk-17-jdk
fi

# Download Minecraft Server
echo "Downloading PaperMC"
mkdir -p /opt/minecraft
wget "$PAPER_URL" -O "/opt/minecraft/paper-${PAPER_VERSION}-${BUILD_NUMBER}.jar"

# Check if Minecraft service exists
if [ -f "$SERVICE_FILE" ]; then
  echo "Minecraft service already exists. Skipping service creation."
else
  # Create Minecraft service
  echo "Creating minecraft service"
  cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=PaperMC Minecraft Server
After=network.target

[Service]
User=$MC_USER
ExecStart=java -jar /opt/minecraft/paper-${PAPER_VERSION}-${BUILD_NUMBER}.jar

[Install]
WantedBy=multi-user.target
EOF
fi

echo "Setup complete"
echo "You can start the server using 'sudo systemctl start minecraft'"
echo "To start the server at boot run: 'sudo systemctl enable minecraft'"
echo "Thanks for using my script :)"
