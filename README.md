# Minecraft Server Setup with PaperMC

This GitLab repository provides a simple bash script for setting up a Minecraft server using PaperMC on a Linux system. The script automates the process of installing Java, creating a dedicated Minecraft user, downloading PaperMC, and setting up a systemd service for easy server management.

## Prerequisites

- This script is designed to run on a Linux system with `systemd` (e.g., Ubuntu).
- Ensure you have root privileges or run the script with `sudo`.

## Usage

1. Clone this repository or download the script directly.

```bash
git clone https://code.wonic.de/ashio/minecraft-installer.git
cd minecraft-installer
```

2. Make the script executable.

```bash
chmod +x installer.sh
```

3. Run the script.

```bash
./installer.sh
```

## Script Details

The script performs the following steps:

1. Checks if the script is run as root.
2. Updates the system and installs Java (OpenJDK 17).
3. Creates a dedicated Minecraft user (`minecraft`) and adjusts permissions on the Minecraft directory.
4. Downloads the specified version of PaperMC.
5. Creates a systemd service for managing the Minecraft server.

## Configuration

- You can customize the Minecraft version by modifying the download link in the script.
- Adjust the `minecraft.service` file if you need to change server configurations.

## Post-Setup

After running the script, the server is ready to use. Additional instructions are provided upon completion:

- Start the server using:

```bash
sudo systemctl start minecraft
```

- Enable automatic startup at boot:

```bash
sudo systemctl enable minecraft
```

## Acknowledgments

Thank you for using this script! Feel free to contribute to the GitLab repository or report any issues.

If you have any questions or need assistance, please open an issue.

Happy Minecrafting! 🎮