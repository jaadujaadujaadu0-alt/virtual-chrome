FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV PORT=8080

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    chromium-browser \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Set up noVNC
RUN mkdir -p /opt/novnc/utils/websockify \
    && ln -s /usr/share/novnc /opt/novnc

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
