#!/bin/bash

# Start the Python HTTP server
python -m http.server 8443 &
SERVER_PID=$!

# Wait for the server to exit
wait $SERVER_PID

# If there are any additional arguments, execute them
if [ $# -gt 0 ]; then
    exec "$@"
fi
