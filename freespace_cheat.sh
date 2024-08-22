#!/bin/bash

# List all open unlinked files and their corresponding PIDs
lsof -nP +L1 | awk 'NR>1 {print $2}' | sort | uniq | while read -r pid; do
    # Gracefully terminate the process holding the unlinked file
    kill -TERM "$pid"
    
    # Wait for a moment to give the process time to clean up
    sleep 2
    
    # Forcefully kill the process if it is still running
    if kill -0 "$pid" 2>/dev/null; then
        kill -KILL "$pid"
    fi
done

# Verify if all unlinked files are closed
if lsof -nP +L1 | grep -q .; then
    echo "Some files are still open:"
    lsof -nP +L1
else
    echo "All unlinked files are now closed."
fi


