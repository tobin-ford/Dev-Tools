#!/bin/bash

# Ensure the correct number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <local_directory>"
    exit 1
fi

LOCAL_DIR="$1"
TEMP_DIR=$(mktemp -d /tmp/esp32_remote.XXXXXX)

# Step 1: Download the remote directory to the temporary location
echo "Downloading remote ESP32 filesystem to $TEMP_DIR..."
bdown.sh "$TEMP_DIR"

if [ $? -ne 0 ]; then
    echo "Error: bdown.sh failed to download files."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Step 2: Perform the diff and display interactively with less
echo "Comparing $LOCAL_DIR with downloaded files in $TEMP_DIR..."
diff -r "$LOCAL_DIR" "$TEMP_DIR" | less -R

# Step 3: Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Diff completed."

