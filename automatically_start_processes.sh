#!/bin/bash

# Define process names (modify as needed)
PROCESS_1="node app.js"
PROCESS_2="node test.js"

# Define folder paths (modify as needed)
FOLDER_1="/path/to/app"
FOLDER_2="/path/to/test"

# Loop to check and restart processes every minute
while :; do
  # Check if processes are running
  if ! pgrep -f "$PROCESS_1" > /dev/null 2>&1; then
    echo "Process $PROCESS_1 not found. Restarting..."

    # Navigate to folder and ensure branch
    cd $FOLDER_1
    git checkout release_app_v1

    # Install dependencies and start process in detached mode  (only works for node process) if using something else replace with it for that running process
    npm install && nohup node app.js &
  fi

  if ! pgrep -f "$PROCESS_2" > /dev/null 2>&1; then
    echo "Process $PROCESS_2 not found. Restarting..."

    # Similar steps for process 2 (modify folder path)
    cd $FOLDER_2
    git checkout release_app_v1
    npm install && nohup node test.js &
  fi

  # Wait for a minute before next check
  sleep 60
done
