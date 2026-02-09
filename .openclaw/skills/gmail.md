# Skill: Gmail

## Purpose
Read, summarize, draft, and send emails via Gmail.

## Access
- OAuth 2.0 with scopes: `gmail.readonly`, `gmail.send`, `gmail.compose`
- Credentials stored in `.env` (never committed)

## Actions

### Read (autonomous)
- Fetch new emails periodically
- Categorize: urgent / needs reply / FYI / spam
- Extract sender, subject, summary (max 3 sentences)
- Send digest to Illia via Telegram

### Draft (autonomous)
- When Illia asks to reply, generate a draft
- Present draft in Telegram for approval

### Send (requires approval)
- NEVER send without "дозволяю" in Telegram
- After approval, send via Gmail API
- Confirm delivery in Telegram

## Contact Graph
- Log every email interaction: sender/recipient, date, subject, channel=gmail
- Link to existing contacts or create new entry
