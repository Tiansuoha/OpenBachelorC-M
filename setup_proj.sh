#!/bin/bash
# OpenBachelorC Setup Project for Android/Termux
# Equivalent of setup_proj.cmd

echo "Setting up project dependencies..."

npm i -D typescript @types/frida-gum @types/node frida-compile frida-il2cpp-bridge frida-java-bridge
npx tsc --init

echo "Project setup completed! Press Enter to continue..."
read
