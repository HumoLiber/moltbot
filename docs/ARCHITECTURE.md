# Moltbot Architecture

## Overview

Moltbot is a locally-hosted AI communications hub. It aggregates messages from 6 channels, builds a unified contact graph, and gives Illia full control via a Telegram bot.

## Components

### 1. OpenClaw Gateway
Long-running daemon that:
- Maintains persistent connections to all messaging channels
- Routes incoming messages to the Moltbot agent
- Manages authentication and session state for each channel
- Runs locally — no cloud relay

### 2. Telegram Control Bot
The only interface for Illia to interact with Moltbot:
- Receives summaries and notifications
- Presents drafts for approval
- Accepts commands: "дозволяю", "ні", "перепиши", etc.
- Every outbound action must be approved here

### 3. Moltbot Agent
AI agent defined by workspace files:
- `identity.md` — role and behavior
- `memory.md` — learned context, contact graph seed
- `soul.md` — immutable principles
- `skills/` — per-channel capabilities + contact graph skill

### 4. Communication Graph
Local CRM-style database:
- Every message (in/out) logged per contact
- Contacts linked across channels (same person on Gmail + WhatsApp = one entry)
- Queryable: "history with X", "unanswered messages", "who haven't I talked to"
- Stored locally as JSON/SQLite

### 5. Channel Integrations

| Channel | Read | Draft | Send | Method |
|---------|------|-------|------|--------|
| Gmail | auto | auto | approval | Gmail API (OAuth) |
| Instagram DM | auto | auto | approval | Instagram API |
| LinkedIn | auto | auto | approval | LinkedIn API |
| WhatsApp | auto | auto | approval | OpenClaw channel (QR) |
| Viber | auto | auto | approval | Viber API |
| Telegram | control | — | — | Telegram Bot API |

### 6. Shinodo Integration (MCP/A2A)
- **MCP** — pulls structured data from Shinodo (events, transcriptions, contacts)
- **A2A** — agent-to-agent communication for coordinated actions
- Used to enrich communication context

### 7. Security Layer
- Docker container isolation
- No outbound data except approved channel APIs
- Telegram-only approval flow
- Audit logging of all actions

## Data Flow

```
[Gmail/Instagram/LinkedIn/WhatsApp/Viber]
                |
          [Gateway daemon]
                |
          [Moltbot Agent]
           /    |    \
    [Skills] [Graph] [Shinodo MCP]
          \    |    /
       [Telegram Bot]
             |
          [Illia]
       дозволяю / ні
```

## Approval Flow

```
New message arrives (any channel)
    → Agent reads and categorizes
    → Summary sent to Telegram
    → If response needed:
        → Agent drafts reply
        → Draft sent to Telegram
        → Illia reviews:
            "дозволяю" → Agent sends on the original channel
            "ні" / edit → Agent adjusts or cancels
```

## Environment Strategy

| Aspect | Choice | Reason |
|--------|--------|--------|
| Hosting | Local Mac | Full control, no cloud risk |
| Isolation | Docker sandbox | Protect host filesystem |
| Sync | iCloud Drive | Multi-workstation access |
| AI Model | Anthropic Claude | Best prompt injection resistance |
| Secrets | .env (gitignored) | Never committed to repo |
| Control | Telegram bot | Single approval channel |
| Data | Local JSON/SQLite | No cloud database |
