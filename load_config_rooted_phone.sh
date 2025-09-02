#!/bin/bash
# OpenBachelorC Load Config for Rooted Phone - Android/Termux
# Equivalent of load_config_rooted_phone.cmd

echo "Loading configuration for rooted phone..."

mkdir -p tmp
jq --indent 4 ".use_su = true | .use_gadget = false" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json

echo "Configuration loaded! Press Enter to continue..."
read
