# Moltbot Architecture

## Overview

Moltbot is a locally-hosted AI assistant that operates through messaging channels (WhatsApp, Discord) and integrates with the Shinodo ecosystem for rich user context.

## Components

### 1. OpenClaw Gateway
The long-running daemon process that:
- Maintains persistent connections to WhatsApp and Discord
- Routes incoming messages to the Moltbot agent
- Manages authentication and session state
- Runs on the local machine (not cloud)

### 2. Moltbot Agent
The AI agent defined by workspace files:
- `identity.md` — personality and purpose
- `memory.md` — learned context and preferences
- `soul.md` — immutable principles (security, privacy)
- `skills/` — modular capabilities

### 3. Shinodo Integration (MCP/A2A)
Protocol-based connection to Shinodo:
- **MCP (Model Context Protocol)** — structured data exchange
- **A2A (Agent-to-Agent)** — inter-agent communication
- Pulls: user events, transcriptions, calendar data, contacts
- Pushes: communication actions, scheduled tasks

### 4. Security Layer
- Docker container isolation
- No outbound data transmission
- Message filtering and validation
- Audit logging

## Data Flow

```
User (WhatsApp/Discord)
    → Gateway (message routing)
        → Agent (AI processing)
            → Skills (action execution)
            → Shinodo MCP/A2A (context retrieval)
        ← Response
    ← Gateway
← User
```

## Environment Strategy

| Aspect | Choice | Reason |
|--------|--------|--------|
| Hosting | Local Mac | Full control, no cloud risk |
| Isolation | Docker sandbox | Protect host filesystem |
| Sync | iCloud Drive | Multi-workstation access |
| AI Model | Anthropic Claude | Best prompt injection resistance |
| Secrets | .env (gitignored) | Never committed to repo |

## Multi-Workstation Setup

The project is stored in iCloud Drive, enabling work from both personal laptop and office workstation. Sensitive configuration (tokens, keys) must be set up independently on each machine via `.env` files that are gitignored.
