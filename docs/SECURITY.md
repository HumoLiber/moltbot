# Moltbot Security Guide

## Philosophy: AI as a New Employee

Treat Moltbot like onboarding a new hire. It gets its own accounts, limited access, monitored activity, and can be terminated at any time. Five security principles govern everything.

---

## Five Security Principles

### Principle 1: VM/Container Isolation
Moltbot runs inside a Docker container (or UTM VM for maximum isolation), never directly on the host OS.

**Why:** If compromised (prompt injection, malicious skill), damage is confined to the container. Host filesystem, SSH keys, browser data, password managers — all unreachable.

**Implementation:**
```bash
# Build sandbox
docker build -t moltbot-sandbox ./security/

# Run sandboxed
docker run --rm -it \
  --network=moltbot-net \
  --user=moltbot \
  -v $(pwd)/.openclaw:/workspace/.openclaw:rw \
  -v $(pwd)/channels:/workspace/channels:rw \
  --read-only \
  --tmpfs /tmp \
  moltbot-sandbox
```

**Escalation option:** For maximum security, run inside a UTM virtual machine on a dedicated Mac Mini. The Docker container runs inside the VM, creating two layers of isolation.

### Principle 2: Network Segmentation
Whitelist-only outbound traffic. Everything else is blocked.

**Allowed endpoints:**
| Endpoint | Purpose |
|----------|---------|
| `api.anthropic.com` | AI model (Claude) |
| `api.telegram.org` | Control channel |
| `gmail.googleapis.com` | Email |
| `graph.instagram.com` | Instagram DM |
| `api.linkedin.com` | LinkedIn |
| `web.whatsapp.com` | WhatsApp |
| `chatapi.viber.com` | Viber |
| `localhost:3000` | Shinodo MCP/A2A |

**All other traffic: BLOCKED.**

**Tools:**
- Docker network policy (primary)
- Lulu firewall on macOS (secondary, if running outside Docker)

### Principle 3: Least Privilege
Moltbot runs as a non-root, non-admin user with zero sudo access.

**Restrictions:**
- No access to host home directory
- No access to password managers or keychain
- No access to other browser profiles
- Cannot install software
- Cannot modify system files
- Read-only filesystem except workspace and channels directories
- Gmail OAuth scopes: `gmail.readonly` + `gmail.send` only (no `gmail.modify`, no `gmail.settings`)

### Principle 4: Separate Accounts & Credentials
Moltbot gets its own identity — separate from Illia's personal accounts.

**Per-service credentials:**
- Own Anthropic API key (track usage separately)
- Own Telegram bot (created via @BotFather)
- Own Gmail OAuth app (can be revoked independently)
- Own API tokens for each channel

**Why:** If one credential is compromised, revoke it without affecting Illia's personal accounts. All actions are traceable to Moltbot's identity.

### Principle 5: Monitoring & Audit
Every action is logged. Anomalies trigger alerts.

**What gets logged:**
- All messages read (channel, sender, timestamp)
- All drafts generated
- All approvals/rejections from Telegram
- All messages sent (channel, recipient, timestamp)
- All API calls made
- All errors and failures
- All contact graph modifications

**Monitoring:**
```bash
# Built-in audit
openclaw security audit deep

# Health check
openclaw doctor

# Review action log
cat .openclaw/logs/actions.log
```

**Alerts (via Telegram):**
- Failed authentication attempts
- Unusual message volume spikes
- API rate limit hits
- Unrecognized sender patterns

---

## Threat Model

### Primary Threats
1. **Prompt Injection** — malicious messages that manipulate agent behavior
2. **Data Exfiltration** — attempts to extract contact graph or message history
3. **Unauthorized Access** — someone else commanding the bot
4. **Host Compromise** — agent escaping sandbox
5. **Channel Hijacking** — compromised OAuth tokens or session takeover
6. **Token Leakage** — API keys exposed in logs, memory, or git
7. **Malicious Skills** — third-party skills that execute harmful code

### Critical Asset: Communication Graph
The contact graph contains aggregated data from 6 channels. Its compromise would expose all communication history. It must never leave the local machine.

### Mitigation: Model Selection
Use Claude (Anthropic) — larger models are significantly more resistant to prompt injection. Never downgrade to smaller/cheaper models for cost savings at the expense of security.

---

## Secrets Management

- All tokens/keys in `.env` file (gitignored)
- Never hardcode credentials in any file
- Each workstation maintains its own `.env`
- Rotate tokens quarterly
- Gmail OAuth refresh tokens stored locally only
- API keys are Moltbot-specific (not shared with personal use)

---

## Deployment Checklist

### Infrastructure
- [ ] Docker Desktop installed
- [ ] `security/Dockerfile` built successfully
- [ ] `security/docker-compose.yml` configured
- [ ] Network policy: whitelist-only outbound traffic
- [ ] Sandbox tested: agent cannot access host files
- [ ] Lulu firewall installed (optional, for non-Docker runs)

### Credentials
- [ ] `.env` created from `.env.example` (not committed)
- [ ] Anthropic API key: dedicated to Moltbot
- [ ] Telegram bot: created via @BotFather
- [ ] `TELEGRAM_AUTHORIZED_USER_ID` set (only Illia)
- [ ] Gmail OAuth: minimum scopes (readonly + send)
- [ ] All channel tokens: per-channel, revocable

### Runtime
- [ ] Agent runs as non-root user in container
- [ ] `openclaw security audit deep` passed
- [ ] `openclaw doctor` shows no issues
- [ ] Action logging enabled
- [ ] Telegram alerts configured
- [ ] Contact graph database is local-only (verified)

### Ongoing
- [ ] Quarterly token rotation
- [ ] Monthly `openclaw security audit deep`
- [ ] Weekly action log review
- [ ] Immediately revoke tokens on any suspicion
