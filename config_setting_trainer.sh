#!/bin/bash
# OpenBachelorC Config Disable Trainer for Android/Termux
# Equivalent of config_disable_trainer.cmd

read -p "启用训练器? (y/n) " choice
if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    value=true
else
    value=false
fi

mkdir -p tmp
jq --indent 4 ".trainer_enabled = $value" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json
