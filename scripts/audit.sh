#!/bin/bash
# Run security audit and health check
set -e

echo "=== Moltbot Security Audit ==="
echo ""

echo "--- OpenClaw Security Audit ---"
openclaw security audit deep
echo ""

echo "--- OpenClaw Doctor ---"
openclaw doctor
echo ""

echo "--- Docker Container Status ---"
docker ps --filter name=moltbot-agent --format "table {{.Status}}\t{{.Ports}}\t{{.Names}}" 2>/dev/null || echo "Docker not running or container not found"
echo ""

echo "--- .env file check ---"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
if [ -f "$PROJECT_DIR/.env" ]; then
    echo ".env exists (not showing contents for security)"
else
    echo "WARNING: .env file not found!"
fi

echo ""
echo "=== Audit Complete ==="
