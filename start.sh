#!/bin/bash

# Make sure the permissions are correct
chown -R devuser:devuser /home/devuser

# Copy nginx configuration
cp /nginx.conf /etc/nginx/nginx.conf

# Start supervisord to manage all services
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf