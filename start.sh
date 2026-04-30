#!/bin/bash

Xvfb :99 -screen 0 1280x800x16 &
export DISPLAY=:99

fluxbox &

# ✅ Use correct binary
chromium --no-sandbox --disable-dev-shm-usage --disable-gpu &

x11vnc -display :99 -nopw -forever -shared &

websockify --web=/usr/share/novnc 0.0.0.0:$PORT localhost:5900
