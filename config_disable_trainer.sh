#!/bin/bash
# OpenBachelorC Config Disable Trainer for Android/Termux
# Equivalent of config_disable_trainer.cmd

echo "Disabling trainer configuration..."

mkdir -p tmp
# Disable trainer in configuration
jq --indent 4 ".trainer_enabled = false" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json

echo "Trainer disabled! Press Enter to continue..."
read
