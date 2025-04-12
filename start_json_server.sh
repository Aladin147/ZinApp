#!/bin/bash

# Get the local IP address
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    IP=$(ipconfig getifaddr en0)
else
    # Linux
    IP=$(hostname -I | awk '{print $1}')
fi

echo "Starting JSON Server on IP: $IP"
json-server --watch data/db.json --host $IP --port 3000
