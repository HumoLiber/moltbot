# Moltbot Installation Guide

## Prerequisites

- macOS
- Node.js 22+ (`node --version`)
- npm 10+ (`npm --version`)
- Docker Desktop (for sandboxing)
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

Fill in your tokens:
```
# Required for launch
ANTHROPIC_API_KEY=your-key-here
TELEGRAM_BOT_TOKEN=your-telegram-bot-token
TELEGRAM_AUTHORIZED_USER_ID=your-telegram-user-id

# Channel tokens (add as you connect each channel)
GMAIL_CLIENT_ID=
GMAIL_CLIENT_SECRET=
GMAIL_REFRESH_TOKEN=
INSTAGRAM_ACCESS_TOKEN=
LINKEDIN_ACCESS_TOKEN=
VIBER_AUTH_TOKEN=
```

## Step 4: Create Telegram Bot

1. Open Telegram, find @BotFather
2. Send `/newbot`, follow prompts
3. Copy the bot token to `.env` as `TELEGRAM_BOT_TOKEN`
4. Send a message to your bot, then get your user ID:
   ```bash
   curl https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates
   ```
5. Copy your `id` to `.env` as `TELEGRAM_AUTHORIZED_USER_ID`

## Step 5: Connect Channels

### WhatsApp
```bash
openclaw channels login
```
Scan the QR code with your phone.

### Gmail
1. Go to Google Cloud Console → APIs → Credentials
2. Create OAuth 2.0 client (Desktop app type)
3. Enable Gmail API
4. Request scopes: `gmail.readonly`, `gmail.send`
5. Get refresh token and add to `.env`

### Instagram / LinkedIn / Viber
Add tokens to `.env` as you set up each channel. Each channel can be connected independently.

## Step 6: Security Setup

### Docker Sandbox
```bash
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/moltbot
docker compose -f security/docker-compose.yml build
docker compose -f security/docker-compose.yml up
```

### Security Audit
```bash
openclaw security audit deep
openclaw doctor
```

Fix any reported issues before going live.

## Step 7: Launch

```bash
# Direct (for development)
npm start

# Sandboxed (for production)
docker compose -f security/docker-compose.yml up -d
```

## Second Workstation Setup

On your office Mac:
1. iCloud Drive syncs the project automatically
2. Install Node.js 22+, Docker Desktop, OpenClaw
3. Create a new `.env` file (gitignored, won't sync)
4. Run `openclaw onboard` to configure locally
5. Re-scan WhatsApp QR code on this machine
6. Each machine needs its own tokens — they are not shared
