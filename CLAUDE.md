# Moltbot — Claude Code Rules

## Project
Moltbot is a local-first AI communications hub built on OpenClaw. Aggregates messages from Gmail, Instagram, LinkedIn, WhatsApp, Telegram, Viber. Controlled exclusively via Telegram bot. No cloud services.

## Location
`~/Library/Mobile Documents/com~apple~CloudDocs/moltbot/` (iCloud Drive, syncs between machines)

## Language
Communicate in Ukrainian by default. English for code and technical docs.

## Key Directories
- `.openclaw/` — agent workspace (identity, memory, soul, skills)
- `.openclaw/skills/` — per-channel skills + contacts graph
- `channels/` — per-channel configuration
- `development/` — setup guides, notes, research
- `security/` — Docker configs, audit results
- `docs/` — architecture and documentation

## Core Principle
Every outbound action requires Telegram approval. No autonomous sending.

## Commands
- `npm start` — start the agent
- `npm run audit` — security audit
- `npm run doctor` — health check

## Rules
- Never expose API keys or tokens in committed files
- Always check `.gitignore` before adding sensitive files
- Security-first: every change must consider prompt injection risks
- Test in sandbox before running on host
- Telegram is the single source of truth for approvals
