#!/bin/bash

# Update package list and install necessary dependencies
echo "Updating system and installing required dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-pip python3-venv git python3-dev build-essential

# Set up a Python virtual environment in the script's directory
echo "Setting up Python virtual environment..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

python3 -m venv .venv
source .venv/bin/activate

# Install ESPHome
echo "Installing ESPHome..."
pip install --upgrade pip
pip install wheel
pip install esphome

# Verify the installation
echo "Verifying ESPHome installation..."
esphome version

# Set up USB permissions for flashing
echo "Adding user $USER to the dialout group for USB flashing permissions..."
sudo usermod -a -G dialout $USER
echo "Note: You may need to log out and log back in (or restart) for the USB group changes to take effect."

echo "ESPHome installation is complete! Use 'source ${SCRIPT_DIR}/.venv/bin/activate' to activate the environment and use the esphome command."
