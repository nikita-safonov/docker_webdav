#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# DEBUG
[ -z "${DEBUG:-}" ] || set -x

# VARs
export PUID="${PUID:-100}"
export PGID="${PGID:-101}"
export USERNAME="${USERNAME:-}"
export PASSWORD="${PASSWORD:-}"

echo '=== Set user and group identifier'
usermod --non-unique --uid "$PUID" www-data
groupmod --non-unique --gid "$PGID" www-data

echo '=== Set authentication'
if [ -n "${USERNAME}" ] && [ -n "${PASSWORD}" ]; then
  htpasswd -bc /etc/nginx/htpasswd "${USERNAME}" "${PASSWORD}"
  echo "== User ${USERNAME} created"
elif [ -f /etc/nginx/htpasswd ]; then
  echo '== Using mounted htpasswd - /etc/nginx/htpasswd'
else
  echo '== No authentication method provided'
fi

echo '=== Set permissions'
mkdir -p /media/
chown -R "${PUID}:${PGID}" /media/

echo '=== Start daemon'
nginx -g "daemon off;"
