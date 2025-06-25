#!/bin/bash

# Make sure the permissions are correct
chown -R devuser:devuser /home/devuser

# Copy nginx configuration
cp /nginx.conf /etc/nginx/nginx.conf

# Copy supervisord configuration
cp /supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start guacd service
/usr/local/sbin/guacd -b 127.0.0.1 -f &

# Configure XRDP for the user
mkdir -p /home/devuser/.xrdp
echo "devuser:password" | chpasswd

# Start supervisord to manage all services
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf