#!/usr/bin/env bash
set -euo pipefail

CERT_DIR="/etc/nginx/certs"
CRT="${CERT_DIR}/server.crt"
KEY="${CERT_DIR}/server.key"

# Use domain from env (see .env). Fallback to localhost if not set.
CN="${DOMAIN_NAME:-localhost}"

# Generate self-signed cert if missing (1 year)
if [ ! -f "$CRT" ] || [ ! -f "$KEY" ]; then
  echo "Generating self-signed TLS cert for CN=${CN}"
  openssl req -x509 -newkey rsa:4096 -nodes -sha256 \
    -keyout "$KEY" -out "$CRT" -days 365 \
    -subj "/CN=${CN}" \
    -addext "subjectAltName=DNS:${CN}"
fi

# Make sure web root exists (mounted from WordPress volume)
mkdir -p /var/www/html

# Best practice: run master in foreground (PID 1), no 'tail -f' or sleep loops.
exec nginx -g 'daemon off;'
