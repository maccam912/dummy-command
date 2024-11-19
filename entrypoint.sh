#!/bin/bash

# Start the Python HTTPS server
python /app/https_server.py &
SERVER_PID=$!

# Wait for the server to exit
wait $SERVER_PID

# If there are any additional arguments, execute them
if [ $# -gt 0 ]; then
    exec "$@"
fi
