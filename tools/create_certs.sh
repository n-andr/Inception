#!/bin/bash
set -e

CERT_DIR="srcs/requirements/nginx/tools/certs"
CERT_KEY="$CERT_DIR/server.key"
CERT_CRT="$CERT_DIR/server.crt"

if [ -f "$CERT_KEY" ] && [ -f "$CERT_CRT" ]; then
    echo "SSL certificate already exists — skipping."
    exit 0
fi

echo "Generating SSL certificate..."

mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERT_KEY" -out "$CERT_CRT" \
    -subj "/C=DE/ST=Berlin/L=Berlin/O=42School/CN=${USER}.42.fr"

echo "SSL certificate generated successfully."
