#!/data/data/com.termux/files/usr/bin/bash

tsu -s "setprop service.adb.tcp.port 5555"
tsu -s "stop adbd"
tsu -s "start adbd"

sleep 2

cd ~/storage/downloads/OpenBachelorC-M/ && sh main.sh
