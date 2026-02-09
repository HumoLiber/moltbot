#!/bin/bash
# Start Moltbot in sandboxed Docker container
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Check prerequisites
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed. Install Docker Desktop first."
    exit 1
fi

if [ ! -f .env ]; then
    echo "ERROR: .env file not found. Run: cp .env.example .env"
    exit 1
fi

# Build and start
echo "Building Moltbot sandbox..."
docker compose -f security/docker-compose.yml build

echo "Starting Moltbot..."
docker compose -f security/docker-compose.yml up -d

echo "Moltbot is running. Check logs with: docker logs -f moltbot-agent"
