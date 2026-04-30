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
    net-tools \
    ca-certificates \
    fonts-liberation \
    libnss3 \
    libxss1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    && rm -rf /var/lib/apt/lists/*

# 🔥 Install Chromium manually (NO SNAP)
RUN wget https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/1095492/chrome-linux.zip \
    && apt-get update && apt-get install -y unzip \
    && unzip chrome-linux.zip \
    && mv chrome-linux /opt/chrome \
    && ln -s /opt/chrome/chrome /usr/bin/chromium \
    && rm chrome-linux.zip

# Setup noVNC
RUN ln -s /usr/share/novnc /opt/novnc

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
