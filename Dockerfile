FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lxde \
    xrdp \
    xorgxrdp \
    firefox \
    git \
    curl \
    wget \
    nano \
    vim \
    sudo \
    net-tools \
    iputils-ping \
    python3 \
    python3-pip \
    nodejs \
    npm \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure XRDP
RUN sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
RUN echo "lxsession -s LXDE -e LXDE" > /etc/xrdp/startwm.sh

# Create a user for the development environment
RUN useradd -m -s /bin/bash -G sudo devuser && \
    echo "devuser:password" | chpasswd

# Set up the workspace directory
RUN mkdir -p /home/devuser/workspace && \
    chown -R devuser:devuser /home/devuser

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose RDP port
EXPOSE 3390

# Start services
CMD ["/start.sh"]