# dev.linux.containers

A web-based Linux development environment with LXDE desktop accessible via RDP, hosted at dev.k2lang.org.

## Features

- Ubuntu 22.04 with LXDE desktop environment
- Remote access via RDP (port 3390)
- Pre-installed development tools (git, python, nodejs, etc.)
- Persistent workspace through Docker volumes

## Local Development

To run this environment locally:

```bash
# Clone the repository
git clone https://github.com/JJPEOPLES/dev.linux
cd dev.linux

# Build and start the container
docker-compose up -d

# Connect via RDP client to localhost:3390
# Username: devuser
# Password: password
```

## Accessing the Hosted Environment

The environment is hosted at dev.k2lang.org:3390 and can be accessed using any RDP client:

1. Open your RDP client (like Microsoft Remote Desktop)
2. Connect to dev.k2lang.org:3390
3. Use the following credentials:
   - Username: devuser
   - Password: password

## Security Notice

This is a development environment. For production use, please:
- Change the default password
- Set up proper authentication
- Consider adding SSL/TLS for secure connections
