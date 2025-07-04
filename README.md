# dev.linux.containers

A web-based Linux development environment with LXDE desktop accessible directly in your browser, hosted at dev.k2lang.org.

## Features

- Ubuntu 22.04 with LXDE desktop environment
- Browser-based access via Apache Guacamole RDP client (no client software needed)
- Pre-installed development tools (git, python, nodejs, etc.)
- Persistent workspace through Docker volumes

## Local Development

### Fast Build (Recommended)

For a faster build that doesn't rely on apt-get, you can pre-download all the necessary .deb packages:

```bash
# Clone the repository
git clone https://github.com/yourusername/dev.linux.containers.git
cd dev.linux.containers

# Download all required .deb packages (only needs to be done once)
./download-debs.sh

# Build and run the container
docker-compose up -d
```

### Standard Build

If you prefer not to pre-download packages:

```bash
# Clone the repository
git clone https://github.com/yourusername/dev.linux.containers.git
cd dev.linux.containers

# Build and start the container
docker-compose up -d
```

The container will download all packages during the build process, which may take longer.

### Access

Once running, open your browser and navigate to: http://localhost:8080
- Username: devuser
- Password: password

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