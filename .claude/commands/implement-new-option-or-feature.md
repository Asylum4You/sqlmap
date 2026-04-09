---
name: implement-new-option-or-feature
description: Workflow command scaffold for implement-new-option-or-feature in sqlmap.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /implement-new-option-or-feature

Use this workflow when working on **implement-new-option-or-feature** in `sqlmap`.

## Goal

Add a new command-line option or feature, updating settings, option parsing, and configuration.

## Common Files

- `lib/core/settings.py`
- `lib/parse/cmdline.py`
- `lib/core/option.py`
- `lib/core/optiondict.py`
- `sqlmap.conf`
- `lib/core/agent.py`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Edit lib/core/settings.py to add new option constants or defaults.
- Edit lib/parse/cmdline.py to parse the new option.
- Edit lib/core/option.py and/or lib/core/optiondict.py to handle the new option.
- Edit sqlmap.conf to document the new option.
- Edit or add implementation files as needed (e.g., lib/core/agent.py, lib/techniques/union/test.py).

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.