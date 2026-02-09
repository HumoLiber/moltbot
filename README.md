# Moltbot

Local-first AI communications hub built on [OpenClaw](https://github.com/openclaw). Manages all your messaging channels from one place, controlled via Telegram.

## What It Does

- **Unified inbox** — aggregates messages from Gmail, Instagram DM, LinkedIn, WhatsApp, Telegram, Viber
- **Communication graph** — CRM-style contact history across all channels (who said what, where, when)
- **Smart actions** — drafts replies, sends messages on your behalf after you approve in Telegram
- **Shinodo integration** — pulls user data via MCP/A2A for context-aware communication
- **100% local** — no cloud, no data leaves your machine

## Architecture

```
[Data Sources]                    [Control Channel]
 Gmail ──────────┐                   [Telegram Bot]
 Instagram DM ──┤                     ↑ approve
 LinkedIn DM ───┤                        |
 WhatsApp ──────┼──→ [Gateway] ──→ [Moltbot Agent] ──→ actions
 Telegram ──────┤        ↑            ↓
 Viber ─────────┘    OpenClaw    [Contact Graph]
                                      ↓
                              [Shinodo MCP/A2A]
```

## How Control Works

1. Moltbot reads new messages from all channels
2. Sends you a summary/notification in **Telegram**
3. You reply with approval, edits, or rejection
4. Moltbot executes the approved action

Nothing happens without your explicit "дозволяю" in Telegram.

## Prerequisites

- Node.js 22+
- Docker (for sandboxing)
- OpenClaw (`npm install -g openclaw`)
- Telegram bot token (via @BotFather)

## Quick Start

```bash
npm install -g openclaw
openclaw onboard --install-demon
openclaw channels login
openclaw security audit deep
```

## Project Structure

```
moltbot/
├── .openclaw/              # Agent workspace (brain)
│   ├── identity.md         # Who Moltbot is
│   ├── memory.md           # What Moltbot remembers
│   ├── soul.md             # Fundamental principles
│   └── skills/             # Capability modules
│       ├── gmail.md        # Email processing
│       ├── instagram.md    # Instagram DM
│       ├── linkedin.md     # LinkedIn messaging
│       ├── whatsapp.md     # WhatsApp
│       ├── viber.md        # Viber
│       └── contacts.md     # Communication graph
├── channels/               # Channel-specific configs
│   ├── telegram/           # Control channel (bot)
│   ├── gmail/
│   ├── instagram/
│   ├── linkedin/
│   ├── whatsapp/
│   └── viber/
├── security/               # Docker, sandboxing, audits
├── development/            # Setup guides, notes, research
├── scripts/                # Automation
└── docs/                   # Documentation
```

## Security Model

- **Local-only** — all data on your machine, zero cloud
- **Docker sandbox** — agent isolated from host filesystem
- **Telegram approval** — every outbound action requires your OK
- **Channel lockdown** — only your accounts, no external access
- **Regular audits** — `openclaw security audit deep`

## Sync

iCloud Drive — works on personal laptop and office workstation. Secrets (`.env`) are gitignored and set up per machine.

## License

Private project.
