#!/bin/bash
# OpenBachelorC Main Script (No Proxy) for Android/Termux
# Equivalent of main_no_proxy.cmd

python -m pipx run poetry run main --no-proxy
echo "Press Enter to continue..."
read
