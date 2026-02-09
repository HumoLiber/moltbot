# Skill: Cursor IDE

## Purpose
Coordinate with Cursor IDE — manage workspace sessions, leverage Cursor's AI features, and bridge between Cursor's capabilities and Moltbot's communication layer.

## Actions

### Read (autonomous)
- Monitor active Cursor workspaces and their state
- Read .cursorrules and .cursor/ configurations from projects
- Check Cursor's composer history and suggestions

### Coordinate (autonomous)
- Sync context between Claude Code sessions and Cursor sessions
- When Illia works in Cursor, Moltbot can provide additional context from communication graph
- Prepare project context for Cursor sessions (relevant emails, messages about the project)

### Execute (requires approval)
- Open specific projects in Cursor
- Apply .cursorrules updates across projects
- Trigger Cursor agent tasks via CLI

## Integration with Communication Graph
When Illia gets a message about a project (e.g., bug report via email, feature request via LinkedIn):
1. Moltbot summarizes in Telegram
2. If Illia says "open in cursor" — Moltbot opens the relevant project
3. Provides context from the communication (who asked, what exactly, history)

## Project Configurations

### Shinodo
- Path: `/Users/ilia/development/shinodo/`
- Rules: `.cursorrules` (144 lines — iOS preflight, web dev validation)

### Moltbot
- Path: `~/Library/Mobile Documents/com~apple~CloudDocs/moltbot/`
- Rules: `CLAUDE.md`

## Constraints
- Never modify .cursorrules without approval
- Cursor sessions are informational — actual code changes go through Claude Code skill
- Respect project-specific AI rules and conventions
