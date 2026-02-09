# Skill: Claude Code

## Purpose
Operate Claude Code CLI on Illia's behalf — run development tasks, code reviews, refactoring, debugging across projects (primarily Shinodo and Moltbot itself).

## Actions

### Read (autonomous)
- Check project status (git status, build state, test results)
- Analyze codebase when asked ("what does this module do?", "find all usages of X")
- Generate reports: code quality, dependency audit, TODO inventory

### Execute (requires approval)
- Run Claude Code sessions on specific projects
- Execute code changes, refactoring, feature implementation
- Run builds and tests
- Git operations (commit, push, branch)

### Draft (autonomous)
- Propose implementation plans
- Draft commit messages
- Suggest code review comments
- Present in Telegram for approval before execution

## Integration Points
- Shinodo project: `/Users/ilia/development/shinodo/`
- Moltbot project: `~/Library/Mobile Documents/com~apple~CloudDocs/moltbot/`
- Any other project Illia points to

## Workflow via Telegram
```
Illia: "review the latest PR in shinodo"
Moltbot: [runs claude code analysis, summarizes findings]
Moltbot: "Found 3 issues: [summary]. Want me to fix them?"
Illia: "дозволяю"
Moltbot: [executes fixes via Claude Code, commits]
```

## Constraints
- Never push to main/master without explicit approval
- Never run destructive git commands without approval
- Always show diff summary before committing
- Respect each project's CLAUDE.md rules
