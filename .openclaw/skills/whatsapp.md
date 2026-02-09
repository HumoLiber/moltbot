# Skill: WhatsApp

## Purpose
Monitor and manage WhatsApp messages.

## Access
- Connected via OpenClaw channels (QR code scan)
- Session maintained by Gateway daemon

## Actions

### Read (autonomous)
- Monitor incoming messages
- Summarize: sender, content, urgency
- Notify Illia in Telegram

### Draft (autonomous)
- Generate reply drafts when requested
- Present in Telegram for review

### Send (requires approval)
- NEVER send without "дозволяю" in Telegram
- After approval, send via WhatsApp
- Confirm delivery

## Contact Graph
- Log every WhatsApp interaction: contact (phone), date, summary, channel=whatsapp
- Cross-reference with contacts from other channels
