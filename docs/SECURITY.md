# Moltbot Security Guide

## Threat Model

### Primary Threats
1. **Prompt Injection** — malicious messages via any channel that manipulate agent behavior
2. **Data Exfiltration** — attempts to extract contact graph or message history
3. **Unauthorized Access** — someone else sending commands to the bot
4. **Host Compromise** — agent escaping sandbox to access host filesystem
5. **Channel Hijacking** — compromised OAuth tokens or session takeover

### Critical Asset: Communication Graph
The contact graph contains aggregated data from 6 channels. Its compromise would expose all communication history. It must never leave the local machine.

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

## 2. Telegram-Only Approval

- Every outbound action requires explicit approval in Telegram
- Only messages from `TELEGRAM_AUTHORIZED_USER_ID` are processed as commands
- All other Telegram messages are ignored
- If Telegram is unreachable, all actions pause

## 3. Channel Restrictions

| Channel | Authorization |
|---------|--------------|
| Telegram | Bot token + authorized user ID |
| Gmail | OAuth 2.0 (read + send scopes only) |
| Instagram | Access token, your account only |
| LinkedIn | Access token, your account only |
| WhatsApp | QR session, your number only |
| Viber | Auth token, your account only |

## 4. Model Selection

Use Claude (Anthropic) — larger models are significantly more resistant to prompt injection than smaller ones.

## 5. Regular Audits

```bash
openclaw security audit deep
openclaw doctor
```

## 6. Secrets Management

- All tokens/keys in `.env` file (gitignored)
- Never hardcode credentials
- Each workstation maintains its own `.env`
- Rotate tokens periodically
- Gmail OAuth refresh tokens stored locally only

## 7. Network Policy

No outbound connections except:
- Anthropic API (AI model)
- Telegram Bot API
- Gmail API
- Instagram Graph API
- LinkedIn API
- WhatsApp Web socket
- Viber API
- Shinodo local MCP/A2A endpoint (localhost only)

All other traffic blocked at Docker network level.

## Checklist

- [ ] Docker installed and configured
- [ ] `.env` created with all tokens (not committed)
- [ ] Telegram bot created, authorized user ID set
- [ ] Gmail OAuth configured with minimum scopes
- [ ] All channel tokens configured
- [ ] `openclaw security audit deep` passed
- [ ] `openclaw doctor` shows no issues
- [ ] Network policy applied in Docker compose
- [ ] Sandbox tested — agent cannot access host files
- [ ] Contact graph database is local-only (verified)
