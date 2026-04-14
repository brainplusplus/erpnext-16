#!/bin/bash
# Helper script to build the custom ERPNext image locally
# EasyPanel will automatically build using docker-compose, this is just for manual/local builds.

echo "Building custom ERPNext image: custom-erpnext:v16.13.3"
docker build -t custom-erpnext:v16.13.3 .
echo "Build complete."
