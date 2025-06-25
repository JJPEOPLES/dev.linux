# dev.linux.containers

A web-based Linux development environment with LXDE desktop accessible directly in your browser, hosted at dev.k2lang.org.

## Features

- Ubuntu 22.04 with LXDE desktop environment
- Browser-based access via noVNC (no client software needed)
- Pre-installed development tools (git, python, nodejs, etc.)
- Persistent workspace through Docker volumes

## Local Development

To run this environment locally:

```bash
# Clone the repository
git clone https://github.com/yourusername/dev.linux.containers.git
cd dev.linux.containers

# Build and start the container
docker-compose up -d

# Access the desktop environment
Open your browser and navigate to: http://localhost:8080
Password: password
```

## Accessing the Hosted Environment

The environment is hosted at dev.k2lang.org and can be accessed using any modern web browser:

1. Open your web browser (Chrome, Firefox, Safari, Edge, etc.)
2. Navigate to https://dev.k2lang.org
3. Enter the password when prompted: `password`

## Security Notice

This is a development environment. For production use, please:
- Change the default password
- Set up proper authentication
- Consider adding SSL/TLS for secure connections