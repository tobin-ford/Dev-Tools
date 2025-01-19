#!/bin/bash

# Define the remote base path (ESP32 root directory)
REMOTE_BASE_PATH=":/"

# Check if a local base path argument is provided
if [ -z "$1" ]; then
    echo "provide directory"
    exit 152
else
    LOCAL_BASE_PATH="$1"
fi

# Function to recursively copy files from ESP32
function download_files() {
    local remote_path="$1"
    local local_path="$2"

    # Create the local directory if it doesn't exist
    mkdir -p "$local_path"

    # List files and directories on the ESP32
    mpremote connect auto fs ls "$remote_path" | tail -n +2 | while read -r size name; do
        if [[ -z "$name" ]]; then
            continue  # Skip invalid lines
        fi

        # Build full remote and local paths
        local remote_item_path="${remote_path}${name}"
        local local_item_path="${local_path}/${name}"

        # Check if it's a directory (directories have trailing '/')
        if [[ "$name" == */ ]]; then
            # It's a directory, recursively download its contents
            local sub_remote_path="${remote_item_path}"
            local sub_local_path="${local_item_path%/}"
            echo "Entering directory $sub_remote_path"
            download_files "$sub_remote_path" "$sub_local_path"
        else
            # It's a file, copy it
            echo "Downloading $remote_item_path -> $local_item_path"
            mpremote connect auto cp "$remote_item_path" "$local_item_path"
        fi
    done
}

# Start downloading from the base path
echo "Starting download from $REMOTE_BASE_PATH to $LOCAL_BASE_PATH..."
download_files "$REMOTE_BASE_PATH" "$LOCAL_BASE_PATH"

echo "All files have been downloaded to $LOCAL_BASE_PATH."

