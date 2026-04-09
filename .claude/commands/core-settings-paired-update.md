---
name: core-settings-paired-update
description: Workflow command scaffold for core-settings-paired-update in sqlmap.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /core-settings-paired-update

Use this workflow when working on **core-settings-paired-update** in `sqlmap`.

## Goal

Update or fix a feature by modifying lib/core/settings.py together with one or more related core or plugin files.

## Common Files

- `lib/core/settings.py`
- `lib/core/common.py`
- `lib/request/connect.py`
- `plugins/dbms/mysql/fingerprint.py`
- `plugins/dbms/h2/fingerprint.py`
- `plugins/dbms/oracle/fingerprint.py`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Edit lib/core/settings.py to update/add/remove a setting or constant.
- Edit one or more related files (e.g., lib/core/common.py, lib/request/connect.py, plugins/dbms/*/fingerprint.py, lib/core/agent.py, etc.) to implement or support the change.
- Commit both changes together with a reference to the issue or feature.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.