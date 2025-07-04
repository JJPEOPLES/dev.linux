#!/bin/bash

# Create directories for .deb files
mkdir -p debs/main
mkdir -p debs/guacamole

# Download main packages
cd debs/main
wget -q http://archive.ubuntu.com/ubuntu/pool/main/l/lxde-common/lxde-common_0.99.2-3_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/l/lxde-icon-theme/lxde-icon-theme_0.5.1-2_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/l/lxde-core/lxde-core_11_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/x/xrdp/xrdp_0.9.17-2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/n/net-tools/net-tools_1.60+git20181103.0eebece-1ubuntu5_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/f/firefox/firefox_99.0+build2-0ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/g/git/git_2.34.1-1ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/c/curl/curl_7.81.0-1ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/w/wget/wget_1.21.2-2ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/n/nano/nano_6.2-1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/v/vim/vim_8.2.3995-1ubuntu2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/s/sudo/sudo_1.9.9-1ubuntu2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/i/iputils/iputils-ping_20211215-1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/p/python3-defaults/python3_3.10.4-0ubuntu2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/p/python-pip/python3-pip_22.0.2+dfsg-1_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/n/nodejs/nodejs_12.22.9~dfsg-1ubuntu3_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/n/npm/npm_8.5.1~ds-1_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/b/build-essential/build-essential_12.9ubuntu3_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/s/supervisor/supervisor_4.2.1-1ubuntu1_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/n/nginx/nginx_1.18.0-6ubuntu14_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/d/dbus/dbus-x11_1.12.20-2ubuntu4_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/x/x11-xserver-utils/x11-xserver-utils_7.7+9_amd64.deb

# Download Guacamole dependencies
cd ../guacamole
wget -q http://archive.ubuntu.com/ubuntu/pool/main/o/openjdk-11/openjdk-11-jdk_11.0.15+10-0ubuntu0.22.04.1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/t/tomcat9/tomcat9_9.0.43-1ubuntu1_all.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/c/cairo/libcairo2-dev_1.16.0-5ubuntu2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-dev_8c-2ubuntu8_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/libp/libpng1.6/libpng-dev_1.6.37-3build5_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/o/ossp-uuid/libossp-uuid-dev_1.6.2-1.5build7_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/f/ffmpeg/libavcodec-dev_4.4.1-3ubuntu5_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/f/ffmpeg/libavutil-dev_4.4.1-3ubuntu5_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/f/ffmpeg/libswscale-dev_4.4.1-3ubuntu5_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/f/freerdp2/libfreerdp-dev_2.4.1+dfsg1-1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/p/pango1.0/libpango1.0-dev_1.50.6+ds-2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/libs/libssh2/libssh2-1-dev_1.10.0-3_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtelnet/libtelnet-dev_0.21-1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/libv/libvncserver/libvncserver-dev_0.9.13+dfsg-3build2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/libpulse-dev_15.99.1+dfsg1-1ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl-dev_3.0.2-0ubuntu1_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/libv/libvorbis/libvorbis-dev_1.3.7-1build2_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/libw/libwebp/libwebp-dev_1.2.2-2_amd64.deb

# Download Guacamole server RPM
wget -q "https://github.com/apache/guacamole-server/releases/download/1.4.0/guacamole-server-1.4.0-1.el8.x86_64.rpm"

# Download Guacamole client WAR
wget -q "https://downloads.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war" -O guacamole.war

echo "All packages downloaded successfully!"