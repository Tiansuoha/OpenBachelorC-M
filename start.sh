#!/data/data/com.termux/files/usr/bin/bash

# Execution confirmation
echo "The script will perform the following operations:"
echo "1. Enable network ADB (set port 5555)"
echo "2. Restart ADB service"
echo "3. Change to specified directory and execute main.sh"
read -p "Do you want to continue? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Operation cancelled"
    exit 1
fi

# Enable network ADB
tsu -s "setprop service.adb.tcp.port 5555"
tsu -s "stop adbd"
tsu -s "start adbd"

# Wait for ADB service to start
sleep 2

cd ~/storage/downloads/OpenBachelorC-M/ && sh main.sh