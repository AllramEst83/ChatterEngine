#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if archive file was provided
if [ -z "$1" ]; then
    echo "❌ Usage: $0 archive.tar.gz [output_dir]"
    exit 1
fi

ARCHIVE="$1"

# Check if the archive exists
if [ ! -f "$ARCHIVE" ]; then
    echo "❌ File not found: $ARCHIVE"
    exit 1
fi

# Resolve full path to archive if given as relative
ARCHIVE_PATH="$(realpath "$ARCHIVE")"

# Determine output directory
if [ -z "$2" ]; then
    BASENAME=$(basename "$ARCHIVE" .tar.gz)
    OUTPUT_DIR="$SCRIPT_DIR/$BASENAME"
else
    OUTPUT_DIR="$SCRIPT_DIR/$2"
fi

# Create the output directory structure if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "📦 Extracting $ARCHIVE_PATH to $OUTPUT_DIR..."

# Extract archive
tar -xzf "$ARCHIVE_PATH" -C "$OUTPUT_DIR"

if [ $? -eq 0 ]; then
    echo "✅ Successfully extracted to: $OUTPUT_DIR"
else
    echo "❌ Extraction failed!"
    exit 1
fi


# Basic usage (extract to ./archive-name)
# ./unpack-tar-gz.sh my-archive.tar.gz

# With custom output folder (relative to script)
# ./unpack-tar-gz.sh my-archive.tar.gz extracted/stuff/here
