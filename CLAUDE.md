# Moltbot — Claude Code Rules

## Project
Moltbot is a local-first AI assistant built on OpenClaw. It runs entirely on the user's machine with Docker sandboxing. No cloud services.

## Location
`~/Library/Mobile Documents/com~apple~CloudDocs/moltbot/` (iCloud Drive, syncs between machines)

## Language
Communicate in Ukrainian by default. English for code and technical docs.

## Key Directories
- `.openclaw/` — agent workspace (identity, memory, soul, skills)
- `development/` — setup guides, notes, research
- `channels/` — WhatsApp/Discord channel configs
- `security/` — Docker configs, audit results
- `docs/` — architecture and documentation

## Commands
- `npm start` — start the agent
- `npm run audit` — security audit
- `npm run doctor` — health check

## Rules
- Never expose API keys or tokens in files that get committed
- Always check `.gitignore` before adding sensitive files
- Security-first: every change must consider prompt injection risks
- Test in sandbox before running on host
