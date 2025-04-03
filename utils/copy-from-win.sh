#!/bin/bash

# Variables
WIN_PATH="/mnt/c/Users/kay.wiberg/Downloads"
WSL_TARGET_DIR="$HOME/projects/chatterengine"

# Function to copy files
copy_files() {
    echo "Copying from Windows: $WIN_PATH"
    echo "To WSL2: $WSL_TARGET_DIR"
    
    cp -rv "$WIN_PATH"/* "$WSL_TARGET_DIR"/
    
    if [ $? -eq 0 ]; then
        echo "✅ Copy successful!"
    else
        echo "❌ Copy failed!"
    fi
}

# Run the copy
copy_files
