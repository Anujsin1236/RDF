#!/bin/bash

# Start dummy HTTP server to keep Render Web Service alive
python3 -m http.server 8080 &

# Start tmate in background
tmate -S /tmp/tmate.sock new-session -d

# Wait for tmate to be ready
tmate -S /tmp/tmate.sock wait tmate-ready

# Print SSH and web access link
echo "=============================="
echo "✅ Tmate SSH session ready:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
echo "🌐 Web URL:"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'
echo "=============================="

# Keep the tmate session alive by repeatedly running it in the foreground,
# or alternatively just keep the script alive with a heartbeat log.

# Assuming you want to keep the tmate session alive by running `tmate -F` in a loop:
while true; do
    tmate -F
    sleep 60
done

# Note: The below infinite loop will never be reached because of the above infinite loop
# If you want to keep printing heartbeat instead, comment out the tmate loop above and uncomment this:

 while true; do
    echo "💤 Still alive: $(date)"
    sleep 100
 done
