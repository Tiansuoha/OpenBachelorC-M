#!/bin/bash
# OpenBachelorC Build JavaScript Alternative for Android/Termux
# Equivalent of build_js_alt.cmd

echo "Building JavaScript files (alternative method)..."

npx tsc
npx webpack -o tmp/alt/

echo "Alternative build completed! Press Enter to continue..."
read
