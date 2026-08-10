---
name: tzai-image
description: Use when the user asks to ... [trigger description that tells agents when to invoke this skill]
metadata:
  author: kedoupi
  version: "0.1.0"
  requires:
    bins: []
---

# tzai-image

[One paragraph: what this skill does, default behavior, key constraints.]

## Prerequisites

```bash
# Verify required CLI / auth
# <cli> auth status --verify
```

## Locating the helper

```bash
# Common install locations:
#   Canonical / symlink source: ~/.agents/skills/tzai-image/
#   Claude:  ~/.claude/skills/tzai-image/
#   Codex:   ~/.codex/skills/tzai-image/
#   Project: ./.agents/skills/tzai-image/
```

Scripts resolve their real path with `pwd -P` so symlink installs share one config.

## Config

One-time after install (if this skill needs durable config):

```bash
bash <skill-dir>/scripts/tzai-image init --chat-id <id>
```

Config is stored **outside** the skill package (survives `npx skills update`).
See incubator schema: durable path is `<skills-parent>/.skill-data/tzai-image/config.env`.

Inspect:

```bash
bash <skill-dir>/scripts/tzai-image config-path
bash <skill-dir>/scripts/tzai-image which-config
```

## Safety

[Describe what agents must confirm before taking real action.]

If the user runs the helper script directly, that invocation is the approval.
For previews, use `--dry-run` (must stay offline / side-effect free).

## Usage

```bash
# Preview (local only)
bash <skill-dir>/scripts/tzai-image --dry-run --title "Example" --body "- item"

# Real action
bash <skill-dir>/scripts/tzai-image --title "Hello" --body "World"
```

## Key CLI options

```text
--title <text>
--body <text>     # may start with '-'
--dry-run         # local preview only
```

Full reference: `bash <skill-dir>/scripts/tzai-image --help`.
