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
    openjdk-11-jdk \
    tomcat9 \
    unzip \
    alien \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure XRDP
RUN sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini && \
    echo "#!/bin/sh\nexec startlxde" > /etc/xrdp/startwm.sh && \
    chmod +x /etc/xrdp/startwm.sh

# Download and install Guacamole Server
RUN mkdir -p /opt/guacamole && \
    cd /tmp && \
    wget -q "https://github.com/apache/guacamole-server/releases/download/1.4.0/guacamole-server-1.4.0-1.el8.x86_64.rpm" && \
    alien --to-deb --scripts guacamole-server-1.4.0-1.el8.x86_64.rpm && \
    dpkg -i guacamole-server_1.4.0-2_amd64.deb || true && \
    apt-get update && \
    apt-get -f install -y --no-install-recommends && \
    ldconfig && \
    rm -rf /tmp/guacamole-server* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Guacamole Client
RUN cd /opt/guacamole && \
    wget -q "https://downloads.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war" -O guacamole.war && \
    mkdir -p /var/lib/tomcat9/webapps && \
    cp guacamole.war /var/lib/tomcat9/webapps/ && \
    mkdir -p /opt/guacamole/web && \
    unzip -q guacamole.war -d /opt/guacamole/web && \
    rm guacamole.war

# Configure Guacamole
RUN mkdir -p /etc/guacamole && \
    echo "guacd-hostname: localhost" > /etc/guacamole/guacamole.properties && \
    echo "guacd-port: 4822" >> /etc/guacamole/guacamole.properties && \
    echo "user-mapping: /etc/guacamole/user-mapping.xml" >> /etc/guacamole/guacamole.properties

# Copy Guacamole user mapping
COPY guacamole-user-mapping.xml /etc/guacamole/user-mapping.xml

# Create a user for the development environment
RUN useradd -m -s /bin/bash -G sudo devuser && \
    echo "devuser:password" | chpasswd

# Set up the workspace directory
RUN mkdir -p /home/devuser/workspace && \
    chown -R devuser:devuser /home/devuser

# Copy workspace files
COPY workspace/ /home/devuser/workspace/
RUN chown -R devuser:devuser /home/devuser/workspace

# Configure supervisor
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy configuration files
COPY start.sh /start.sh
COPY nginx.conf /nginx.conf
RUN chmod +x /start.sh

# Expose web port
EXPOSE 8080

# Start services
CMD ["/start.sh"]