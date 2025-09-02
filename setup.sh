#!/bin/bash
# OpenBachelorC Setup Script for Android/Termux
# Equivalent of setup.cmd

echo "Setting up OpenBachelorC for Android/Termux..."

# Install dependencies directly using pip
echo "Installing Python dependencies..."
python -m pip install --upgrade pip
python -m pip install "prompt-toolkit>=3.0.51,<4.0.0"
python -m pip install "requests>=2.32.4,<3.0.0"
python -m pip install "pycryptodome>=3.23.0"

echo "Setup completed! Press Enter to continue..."
read
