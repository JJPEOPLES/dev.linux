FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lxde \
    tightvncserver \
    novnc \
    websockify \
    net-tools \
    firefox \
    git \
    curl \
    wget \
    nano \
    vim \
    sudo \
    iputils-ping \
    python3 \
    python3-pip \
    nodejs \
    npm \
    build-essential \
    supervisor \
    nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a user for the development environment
RUN useradd -m -s /bin/bash -G sudo devuser && \
    echo "devuser:password" | chpasswd

# Set up the workspace directory
RUN mkdir -p /home/devuser/workspace && \
    chown -R devuser:devuser /home/devuser

# Set up VNC password
RUN mkdir -p /home/devuser/.vnc && \
    echo "password" | vncpasswd -f > /home/devuser/.vnc/passwd && \
    chmod 600 /home/devuser/.vnc/passwd && \
    chown -R devuser:devuser /home/devuser/.vnc

# Configure noVNC
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy configuration files
COPY start.sh /start.sh
COPY nginx.conf /nginx.conf
RUN chmod +x /start.sh

# Expose noVNC web port
EXPOSE 8080

# Start services
CMD ["/start.sh"]