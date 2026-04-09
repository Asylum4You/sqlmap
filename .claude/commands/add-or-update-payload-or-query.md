---
name: add-or-update-payload-or-query
description: Workflow command scaffold for add-or-update-payload-or-query in sqlmap.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /add-or-update-payload-or-query

Use this workflow when working on **add-or-update-payload-or-query** in `sqlmap`.

## Goal

Add or update a SQL payload or query file, sometimes pairing with core settings changes.

## Common Files

- `data/xml/payloads/boolean_blind.xml`
- `data/xml/queries.xml`
- `data/procs/oracle/dns_request.sql`
- `lib/core/settings.py`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Edit or add a file in data/xml/payloads/*.xml or data/xml/queries.xml or data/procs/oracle/*.sql.
- Optionally, update lib/core/settings.py to register or reference the new payload/query.
- Commit both changes together.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.