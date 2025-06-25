FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lxde \
    xrdp \
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
    dbus-x11 \
    x11-xserver-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure XRDP
RUN sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini && \
    echo "#!/bin/sh\nexec startlxde" > /etc/xrdp/startwm.sh && \
    chmod +x /etc/xrdp/startwm.sh

# Install Apache Guacamole for web-based RDP access
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    tomcat9 \
    libcairo2-dev \
    libjpeg-dev \
    libpng-dev \
    libossp-uuid-dev \
    libavcodec-dev \
    libavutil-dev \
    libswscale-dev \
    libfreerdp-dev \
    libpango1.0-dev \
    libssh2-1-dev \
    libtelnet-dev \
    libvncserver-dev \
    libpulse-dev \
    libssl-dev \
    libvorbis-dev \
    libwebp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Guacamole Server
RUN mkdir -p /opt/guacamole && \
    cd /opt && \
    wget -q "https://downloads.apache.org/guacamole/1.4.0/source/guacamole-server-1.4.0.tar.gz" && \
    tar -xzf guacamole-server-1.4.0.tar.gz && \
    cd guacamole-server-1.4.0 && \
    ./configure --with-init-dir=/etc/init.d && \
    make && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf guacamole-server-1.4.0 guacamole-server-1.4.0.tar.gz

# Download and install Guacamole Client
RUN cd /opt/guacamole && \
    wget -q "https://downloads.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war" -O guacamole.war && \
    mkdir -p /opt/guacamole/web && \
    unzip -q guacamole.war -d /opt/guacamole/web && \
    rm guacamole.war

# Configure Guacamole
RUN mkdir -p /etc/guacamole && \
    echo "guacd-hostname: localhost" > /etc/guacamole/guacamole.properties && \
    echo "guacd-port: 4822" >> /etc/guacamole/guacamole.properties

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