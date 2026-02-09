# Skill: Communication Graph

## Purpose
Maintain a unified contact database — CRM-style view of every person Illia communicates with across all channels.

## Data Model

Each contact entry contains:
- **Name** — real name or handle
- **Channels** — which platforms (gmail, instagram, linkedin, whatsapp, telegram, viber)
- **Identifiers** — email, phone, social handles (per channel)
- **Last contact** — date and channel of most recent interaction
- **History** — chronological list of interactions across all channels
- **Context** — who this person is, relationship, tags (business/personal/shinodo)
- **Notes** — manually added context from Illia

## Actions

### Query (autonomous)
When Illia asks "what's my history with X?" or "when did I last talk to Y?":
- Search the contact graph
- Return unified timeline across all channels
- Include context and notes

### Update (autonomous)
- Every message read/sent automatically updates the contact graph
- Merge contacts when the same person is detected across channels (same name + email, or manual link)

### Report (autonomous)
- On request, generate communication summary:
  - Most active contacts this week
  - Unanswered messages older than N days
  - Contacts not reached in N days

## Storage
- Local JSON/SQLite database in `channels/` directory
- Never synced to cloud
- Backed up via iCloud Drive (as part of project directory)
