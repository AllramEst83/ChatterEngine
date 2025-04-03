#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default Windows Downloads path
WIN_DOWNLOADS="/mnt/c/Users/kaywi/Downloads"

# Check if file argument was provided
if [ -z "$1" ]; then
    echo "❌ Usage: $0 <filename-in-downloads> [wsl-relative-target-dir]"
    exit 1
fi

FILENAME="$1"
SRC_FILE="$WIN_DOWNLOADS/$FILENAME"

# Check if the source file exists
if [ ! -f "$SRC_FILE" ]; then
    echo "❌ File not found in Windows Downloads: $SRC_FILE"
    exit 1
fi

# Determine destination directory (relative to script if not given)
if [ -z "$2" ]; then
    DEST_DIR="$SCRIPT_DIR"
else
    DEST_DIR="$SCRIPT_DIR/$2"
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

echo "📂 Copying '$SRC_FILE' → '$DEST_DIR'..."

cp -v "$SRC_FILE" "$DEST_DIR"

if [ $? -eq 0 ]; then
    echo "✅ Copy successful!"
else
    echo "❌ Copy failed!"
    exit 1
fi

# Make it executable:
# chmod +x copy-from-win.sh

# Copy file.txt from Downloads to current script dir
# ./copy-from-win.sh file.txt

# Copy file.txt from Downloads to a specific subfolder (created if missing)
# ./copy-from-win.sh file.txt projects/chatterengine
