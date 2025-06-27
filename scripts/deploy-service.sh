#!/bin/bash

set -e

SERVICE=$1

if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

echo "✅ Pulling latest image for $SERVICE..."
docker-compose pull $SERVICE

echo "✅ Restarting $SERVICE..."
docker-compose up -d $SERVICE

echo "✅ Cleaning up dangling images..."
docker image prune -f
