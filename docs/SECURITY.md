# Moltbot Security Guide

## Threat Model

### Primary Threats
1. **Prompt Injection** — malicious messages that manipulate agent behavior
2. **Data Exfiltration** — attempts to extract sensitive data via channels
3. **Unauthorized Access** — someone else messaging the agent
4. **Host Compromise** — agent escaping sandbox to access host filesystem

### Mitigation Strategy

## 1. Sandboxing (Docker)

Run Moltbot in an isolated Docker container:
- Agent can only access its own workspace
- No access to host filesystem, SSH keys, browser data
- Network restricted to required endpoints only

```bash
# Build sandbox
docker build -t moltbot-sandbox ./security/

# Run sandboxed
docker run --rm -it \
  --network=moltbot-net \
  -v $(pwd)/.openclaw:/workspace/.openclaw \
  moltbot-sandbox
```

## 2. Channel Restrictions

Configure OpenClaw to accept messages only from authorized accounts:
- WhatsApp: your phone number only
- Discord: specific user ID / server only

## 3. Model Selection

Use the most capable model available (Claude) — larger models are significantly more resistant to prompt injection than smaller ones.

## 4. Regular Audits

```bash
# Full security audit
openclaw security audit deep

# Health check
openclaw doctor
```

## 5. Secrets Management

- All tokens/keys in `.env` file (gitignored)
- Never hardcode credentials
- Each workstation maintains its own `.env`
- Rotate tokens periodically

## 6. Network Policy

- No outbound connections except:
  - AI model API (Anthropic)
  - WhatsApp Web socket
  - Discord gateway
  - Shinodo local MCP endpoint
- All other traffic blocked at Docker network level

## Checklist

- [ ] Docker installed and configured
- [ ] `.env` file created with tokens (not committed)
- [ ] Channel restrictions configured (authorized accounts only)
- [ ] `openclaw security audit deep` passed
- [ ] `openclaw doctor` shows no issues
- [ ] Network policy applied in Docker compose
- [ ] Sandbox tested — agent cannot access host files
