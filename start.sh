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

# Ensure XRDP is properly configured
if [ ! -f "/etc/xrdp/xrdp.ini" ]; then
    mkdir -p /etc/xrdp
    echo "[globals]" > /etc/xrdp/xrdp.ini
    echo "port=3390" >> /etc/xrdp/xrdp.ini
    echo "max_bpp=32" >> /etc/xrdp/xrdp.ini
    echo "crypt_level=high" >> /etc/xrdp/xrdp.ini
    echo "security_layer=tls" >> /etc/xrdp/xrdp.ini
    echo "allow_channels=true" >> /etc/xrdp/xrdp.ini
    echo "bitmap_compression=true" >> /etc/xrdp/xrdp.ini
    echo "tcp_nodelay=true" >> /etc/xrdp/xrdp.ini
    echo "tcp_keepalive=true" >> /etc/xrdp/xrdp.ini
    echo "autorun=startlxde" >> /etc/xrdp/xrdp.ini
fi

if [ ! -f "/etc/xrdp/startwm.sh" ]; then
    echo "#!/bin/sh" > /etc/xrdp/startwm.sh
    echo "exec startlxde" >> /etc/xrdp/startwm.sh
    chmod +x /etc/xrdp/startwm.sh
fi

# Configure Tomcat
mkdir -p /var/lib/tomcat9/webapps/guacamole
mkdir -p /var/lib/tomcat9/logs
cp -r /opt/guacamole/web/* /var/lib/tomcat9/webapps/guacamole/
mkdir -p /usr/share/tomcat9/bin
if [ ! -f "/usr/share/tomcat9/bin/startup.sh" ]; then
    echo "#!/bin/bash" > /usr/share/tomcat9/bin/startup.sh
    echo "catalina.sh start" >> /usr/share/tomcat9/bin/startup.sh
    chmod +x /usr/share/tomcat9/bin/startup.sh
fi
touch /var/lib/tomcat9/logs/catalina.out
chown -R tomcat:tomcat /var/lib/tomcat9

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
    <iframe src="/guacamole/" allowfullscreen="true"></iframe>
</body>
</html>
EOL

# Ensure guacd is running
if [ ! -f "/usr/local/sbin/guacd" ]; then
    ln -s /usr/local/bin/guacd /usr/local/sbin/guacd
fi

# Start supervisord to manage all services
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf