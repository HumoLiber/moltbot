# Moltbot

Local-first AI assistant built on [OpenClaw](https://github.com/openclaw). Runs entirely on your machine — no cloud, no data leaks.

## What It Does

- Personal AI assistant accessible via WhatsApp and Discord
- Integrates with [Shinodo](https://github.com/user/shinodo) via MCP/A2A protocols for user data and events
- Focuses on communications, event processing, and task coordination
- All data stays local, sandboxed in Docker for security

## Architecture

```
[WhatsApp / Discord]
        |
    [Gateway]  ← OpenClaw long-running process
        |
    [Moltbot Agent]  ← identity + memory + skills
        |
    [Shinodo MCP/A2A]  ← user data, events, context
```

## Prerequisites

- Node.js 22+ (current: v25.4.0)
- Docker (for sandboxing)
- OpenClaw (`npm install -g openclaw`)

## Quick Start

```bash
# Install OpenClaw
npm install -g openclaw

# Run setup wizard
openclaw onboard --install-demon

# Connect WhatsApp
openclaw channels login

# Security audit
openclaw security audit deep
```

## Project Structure

```
moltbot/
├── .openclaw/           # Agent workspace (brain)
│   ├── identity.md      # Who Moltbot is
│   ├── memory.md        # What Moltbot remembers
│   ├── soul.md          # Fundamental principles
│   └── skills/          # Capability modules
├── channels/            # Channel-specific configs
│   ├── whatsapp/
│   └── discord/
├── security/            # Security configs, Docker, audits
├── development/         # Dev notes, setup guides, research
│   ├── setup/           # Installation and config guides
│   ├── notes/           # Working notes
│   └── research/        # Protocol research (MCP, A2A, etc.)
├── scripts/             # Automation scripts
└── docs/                # Documentation
```

## Security Model

- **Local-only execution** — nothing leaves your machine
- **Docker sandboxing** — agent runs in isolated container
- **Prompt injection resistance** — hardened against malicious messages
- **Channel restrictions** — responds only to authorized accounts
- **Regular audits** — `openclaw security audit deep`

## Sync

Project lives in iCloud Drive for seamless sync between workstations. Sensitive config files are gitignored.

## License

Private project.
