#!/bin/bash

# Define the remote base path (ESP32 root directory)
REMOTE_BASE_PATH=":/"

# Check if a local base path argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <local_base_path>"
    exit 1
fi
LOCAL_BASE_PATH="$1"

# Function to recursively upload files to ESP32
function upload_files() {
    local local_path="$1"
    local remote_path="$2"

    # Traverse the local directory
    for item in "$local_path"/*; do
        if [ -d "$item" ]; then
            # It's a directory, create it on the ESP32 and upload its contents
            local sub_remote_path="${remote_path}$(basename "$item")/"
            echo "Creating directory $sub_remote_path"
            mpremote connect auto fs mkdir "$sub_remote_path" 2>/dev/null || true
            upload_files "$item" "$sub_remote_path"
        elif [ -f "$item" ]; then
            # It's a file, upload it
            local remote_file_path="${remote_path}$(basename "$item")"
            echo "Uploading $item -> $remote_file_path"
            mpremote connect auto cp "$item" "$remote_file_path"
        fi
    done
}

# Start uploading from the local base path
echo "Starting upload from $LOCAL_BASE_PATH to $REMOTE_BASE_PATH..."
upload_files "$LOCAL_BASE_PATH" "$REMOTE_BASE_PATH"

echo "All files have been uploaded to $REMOTE_BASE_PATH."

