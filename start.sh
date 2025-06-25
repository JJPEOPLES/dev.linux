#!/bin/bash

# Start XRDP service
service xrdp start

# Keep the container running
tail -f /dev/null