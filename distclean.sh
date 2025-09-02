#!/bin/bash
# OpenBachelorC Clean Build for Android/Termux
# Equivalent of distclean.cmd

echo "Cleaning build files..."

# Remove temporary files
rm -rf tmp/
rm -rf node_modules/
rm -rf .venv/
rm -rf __pycache__/
rm -rf *.pyc
rm -rf .pytest_cache/

# Remove Poetry virtual environment
python -m pipx run poetry env remove --all 2>/dev/null || true

echo "Clean completed! Press Enter to continue..."
read
