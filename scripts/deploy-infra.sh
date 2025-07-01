#!/bin/bash
if [ "$SERVER_IP" = "none" ] || [ -z "$SERVER_IP" ]; then
  echo "🚫 No server IP set. Skipping deploy."
  exit 0
fi
ssh -i "$SERVER_SSH_KEY" "$SERVER_USER@$SERVER_IP" << EOF
cd /home/st120712/infra-docker-compose
git pull
docker compose pull
docker compose up -d
EOF