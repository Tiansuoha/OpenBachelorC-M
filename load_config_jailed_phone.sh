#!/bin/bash
# OpenBachelorC Load Config for Jailed Phone - Android/Termux
# Equivalent of load_config_jailed_phone.cmd

echo "Loading configuration for jailed phone..."

mkdir -p tmp
jq --indent 4 ".use_su = false | .use_gadget = true" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json

echo "Configuration loaded! Press Enter to continue..."
read
