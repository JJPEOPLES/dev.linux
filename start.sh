#!/bin/bash

# Make sure the permissions are correct
chown -R devuser:devuser /home/devuser

# Copy nginx configuration
cp /nginx.conf /etc/nginx/nginx.conf

# Copy supervisord configuration
cp /supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure XRDP for the user
mkdir -p /home/devuser/.xrdp
echo "devuser:password" | chpasswd

# Configure Tomcat
mkdir -p /var/lib/tomcat9/webapps/guacamole
cp -r /opt/guacamole/web/* /var/lib/tomcat9/webapps/guacamole/
# Use --force-yes to avoid prompts
if [ ! -d "/var/lib/tomcat9/conf" ]; then
    apt-get -f install -y --force-yes --no-install-recommends
fi
chown -R tomcat:tomcat /var/lib/tomcat9/webapps/guacamole

# Create a simple HTML file for Guacamole client
mkdir -p /opt/guacamole/web
cat > /opt/guacamole/web/index.html << 'EOL'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Linux Desktop - RDP Connection</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }
        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>
    <iframe src="http://localhost:8080/guacamole/" allowfullscreen="true"></iframe>
</body>
</html>
EOL

# Start supervisord to manage all services
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf