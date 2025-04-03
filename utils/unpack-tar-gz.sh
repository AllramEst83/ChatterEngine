#!/bin/bash

# Check if argument was provided
if [ -z "$1" ]; then
    echo "❌ Usage: $0 archive.tar.gz"
    exit 1
fi

ARCHIVE="$1"

# Check if file exists
if [ ! -f "$ARCHIVE" ]; then
    echo "❌ File not found: $ARCHIVE"
    exit 1
fi

# Create output directory based on archive name
BASENAME=$(basename "$ARCHIVE" .tar.gz)
OUTPUT_DIR="./$BASENAME"

echo "📦 Extracting $ARCHIVE to $OUTPUT_DIR..."

mkdir -p "$OUTPUT_DIR" && tar -xzf "$ARCHIVE" -C "$OUTPUT_DIR"

if [ $? -eq 0 ]; then
    echo "✅ Successfully extracted to: $OUTPUT_DIR"
else
    echo "❌ Extraction failed!"
fi
