#!/bin/bash

# Check if a directory argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

# Get the log directory from the argument
log_dir="$1"

# Check if the provided directory exists
if [ ! -d "$log_dir" ]; then
    echo "Error: Directory '$log_dir' does not exist."
    exit 1
fi

# Create a timestamp for the archive name
timestamp=$(date +"%Y%m%d_%H%M%S")

# Create the archive directory if it doesn't exist
archive_dir="$log_dir/archives"
mkdir -p "$archive_dir"
"log_tool.sh" 32L, 793B
