#!/bin/bash
# OpenBachelorC Config Enable Trainer for Android/Termux
# Equivalent of config_enable_trainer.cmd

echo "Enabling trainer configuration..."

mkdir -p tmp
# Enable trainer in configuration
jq --indent 4 ".trainer_enabled = true" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json

echo "Trainer enabled! Press Enter to continue..."
read
