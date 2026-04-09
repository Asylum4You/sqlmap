```markdown
# sqlmap Development Patterns

> Auto-generated skill from repository analysis

## Overview

This skill teaches you how to contribute effectively to the sqlmap codebase, a Python-based SQL injection tool. You'll learn the project's coding conventions, how to implement new features, update settings, add payloads, and maintain documentation. The guide covers typical workflows, commit practices, and provides command suggestions for common tasks.

## Coding Conventions

- **File Naming:**  
  Use camelCase for file names.  
  _Example:_  
  ```
  connectHandler.py
  optionDict.py
  ```

- **Import Style:**  
  Use relative imports within the package.  
  _Example:_  
  ```python
  from .common import getUnicode
  from ..request import connect
  ```

- **Export Style:**  
  Use named exports; avoid wildcard imports.  
  _Example:_  
  ```python
  def getUnicode(value):
      ...
  ```

- **Commit Messages:**  
  - Freeform style, no strict prefixes.
  - Average length: ~23 characters.
  - Reference issues or features when possible.

## Workflows

### Core Settings Paired Update
**Trigger:** When you need to add, update, or fix a feature or bug that requires changing global settings and related logic.  
**Command:** `/update-setting`

1. Edit `lib/core/settings.py` to update, add, or remove a setting or constant.
2. Edit one or more related files to implement or support the change.  
   _Examples:_  
   - `lib/core/common.py`
   - `lib/request/connect.py`
   - `plugins/dbms/mysql/fingerprint.py`
   - `lib/core/agent.py`
3. Commit both changes together, referencing the relevant issue or feature.

_Example:_
```python
# lib/core/settings.py
NEW_FEATURE_ENABLED = True

# lib/core/common.py
from .settings import NEW_FEATURE_ENABLED

if NEW_FEATURE_ENABLED:
    # new logic here
```

---

### Add or Update Payload or Query
**Trigger:** When you want to support new database payloads, queries, or exfiltration techniques.  
**Command:** `/add-payload`

1. Edit or add a file in:
   - `data/xml/payloads/*.xml`
   - `data/xml/queries.xml`
   - `data/procs/oracle/*.sql`
2. Optionally, update `lib/core/settings.py` to register or reference the new payload/query.
3. Commit both changes together.

_Example:_
```xml
<!-- data/xml/payloads/boolean_blind.xml -->
<payload>
  <type>boolean_blind</type>
  <sql>SELECT ...</sql>
</payload>
```

---

### Implement New Option or Feature
**Trigger:** When introducing a new CLI option or a major feature.  
**Command:** `/add-option`

1. Edit `lib/core/settings.py` to add new option constants or defaults.
2. Edit `lib/parse/cmdline.py` to parse the new option.
3. Edit `lib/core/option.py` and/or `lib/core/optiondict.py` to handle the new option.
4. Edit `sqlmap.conf` to document the new option.
5. Edit or add implementation files as needed (e.g., `lib/core/agent.py`, `lib/techniques/union/test.py`).
6. Commit all related changes together.

_Example:_
```python
# lib/core/settings.py
NEW_OPTION = False

# lib/parse/cmdline.py
parser.add_option("--new-option", action="store_true", dest="new_option", help="Enable new option")

# lib/core/option.py
if conf.new_option:
    # handle new option
```

---

### Documentation or README Update
**Trigger:** When updating documentation or adding a new translation.  
**Command:** `/update-docs`

1. Edit or add files in `doc/translations/` or the main `README.md`.
2. Optionally, update `lib/core/settings.py` if documentation reflects a new/changed feature.
3. Commit documentation changes.

_Example:_
```
# doc/translations/README-de-DE.md
# sqlmap Dokumentation (Deutsch)
...
```

## Testing Patterns

- **Framework:** Unknown (not explicitly detected).
- **Test File Pattern:** Files matching `*.test.*`
- **Typical Test Location:** Scattered; look for files with `.test.` in their names.
- **Style:** No standard framework detected; tests may be run manually or with custom scripts.

_Example:_
```
lib/core/testing.py
lib/techniques/union/test.py
```

## Commands

| Command         | Purpose                                               |
|-----------------|-------------------------------------------------------|
| /update-setting | Update or fix a feature by changing settings and logic|
| /add-payload    | Add or update a SQL payload or query                  |
| /add-option     | Add a new command-line option or major feature        |
| /update-docs    | Update documentation or add a translation             |
```