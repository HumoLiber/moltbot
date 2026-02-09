# Moltbot Installation Guide

## Prerequisites

- macOS
- Node.js 22+ (`node --version`)
- npm 10+ (`npm --version`)
- Docker Desktop
- GitHub CLI (`gh`)

## Step 1: Install OpenClaw

```bash
npm install -g openclaw
```

Verify:
```bash
openclaw --version
```

## Step 2: Initial Setup

```bash
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/moltbot
openclaw onboard --install-demon
```

The wizard will ask:
- **AI Model**: Select Anthropic (Claude) — best security against prompt injection
- **Workspace path**: Point to `.openclaw/` directory in this project
- **Token generation**: Follow prompts to generate API tokens

## Step 3: Environment Configuration

Create `.env` in project root:

```bash
cp .env.example .env
```

Fill in:
```
ANTHROPIC_API_KEY=your-key-here
WHATSAPP_AUTHORIZED_NUMBER=your-phone
DISCORD_BOT_TOKEN=your-discord-token
DISCORD_AUTHORIZED_USER_ID=your-discord-id
```

## Step 4: Connect Channels

### WhatsApp
```bash
openclaw channels login
```
Scan the QR code with your phone.

### Discord
1. Create a bot at https://discord.com/developers/applications
2. Get bot token
3. Add to `.env` as `DISCORD_BOT_TOKEN`
4. Invite bot to your server

## Step 5: Security Audit

```bash
openclaw security audit deep
openclaw doctor
```

Fix any reported issues before proceeding.

## Step 6: Docker Sandbox (Recommended)

```bash
cd security/
docker build -t moltbot-sandbox .
```

## Second Workstation Setup

On your office Mac:
1. iCloud Drive will sync the project automatically
2. Install Node.js 22+ and Docker
3. `npm install -g openclaw`
4. Create a new `.env` file (it's gitignored, won't sync)
5. Run `openclaw onboard` again to configure locally
6. Re-scan WhatsApp QR code on this machine
