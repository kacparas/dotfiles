# Global Claude Instructions

## Behavior
- When you learn important information about a project (architecture decisions, key files, gotchas, etc.), add it to the project's local CLAUDE.md under "Session Notes"
- Keep responses concise and focused
- Prefer editing existing files over creating new ones
- Warn me before performing operations that would consume a large amount of tokens (e.g., reading very large files, extensive searches, processing large documents)

## Session-Specific Behavior
- If in tmux session named "config", look for project CLAUDE.md at `~/.config/CLAUDE.md`
- If in tmux session named "StrucBio", look for project CLAUDE.md at `~/Library/Mobile Documents/com~apple~CloudDocs/msc/2/sb/CLAUDE.md`

## Project CLAUDE.md Template
When creating a new project, use this template for the local CLAUDE.md:

```markdown
# Project: [Name]

## Overview
[Brief description of the project]

## Key Files
- `path/to/file` - Description

## Important Context
- [Key technologies, patterns, decisions]

## Session Notes
<!-- Add important discoveries, decisions, and context here as you work -->
```
