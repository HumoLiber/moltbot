#!/bin/bash
# Stop Moltbot container
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "Stopping Moltbot..."
docker compose -f security/docker-compose.yml down

echo "Moltbot stopped."
