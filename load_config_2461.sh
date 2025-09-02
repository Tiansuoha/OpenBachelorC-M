#!/bin/bash
# OpenBachelorC Load Config for 2461 Device - Android/Termux
# Equivalent of load_config_2461.cmd

echo "Loading configuration for 2461 device..."

mkdir -p tmp
# Note: Add the specific configuration for 2461 device here
# This is a placeholder - you may need to adjust based on the original .cmd content
jq --indent 4 ".use_su = true | .use_gadget = false" conf/config.json > tmp/config.json
mv tmp/config.json conf/config.json

echo "Configuration loaded! Press Enter to continue..."
read
