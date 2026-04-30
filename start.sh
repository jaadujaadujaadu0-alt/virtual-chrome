#!/bin/bash

# Start virtual display
Xvfb :99 -screen 0 1280x800x16 &

export DISPLAY=:99

# Start window manager
fluxbox &

# Start Chromium
chromium-browser --no-sandbox --disable-gpu --disable-dev-shm-usage &

# Start VNC server
x11vnc -display :99 -nopw -forever -shared &

# Start noVNC (Web access)
websockify --web=/usr/share/novnc 0.0.0.0:$PORT localhost:5900
