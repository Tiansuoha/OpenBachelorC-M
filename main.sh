#!/bin/bash
# OpenBachelorC Main Script for Android/Termux
# Equivalent of main.cmd

# Check if frida is installed
if ! python -c "import frida" 2>/dev/null; then
    echo "Error: frida module not detected."
    echo "Please run ./setup.sh to install frida."
    exit 1
fi

# Run with system Python environment (frida is installed in system environment)
# Set PYTHONPATH to include project source code
export PYTHONPATH="$PWD/src/launcher:$PYTHONPATH"
python -m openbachelorc.main

echo "Press Enter to continue..."
read -r