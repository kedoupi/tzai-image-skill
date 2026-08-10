---
name: tzai-architecture
description: >
  Generate System architecture (架构图) images via TaoziAPI using tzai-image kind=architecture.
  Use when the user runs /tzai-architecture, /tzai-image architecture, or asks for 架构图 / System architecture.
  Category: diagram (结构图示). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "架构图 · 结构图示"
  tzai-kind: "architecture"
  tzai-category: "diagram"
---

# tzai-architecture — 架构图

Slash: **`/tzai-architecture`** · Engine kind: **`architecture`** · Category: **结构图示** · Default AR: **16:9**

Thin slash entry for the `architecture` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

## Resolve engine

```bash
ENGINE=""
for c in \
  "$HOME/.agents/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.claude/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.codex/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.grok/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.cursor/skills/tzai-image/scripts/tzai-image"
do
  if [ -x "$c" ]; then ENGINE="$c"; break; fi
done
if [ -z "$ENGINE" ]; then
  echo "Install engine: npx skills add kedoupi/tzai-image-skill -g --all" >&2
  exit 1
fi
```

## Run

Slash arguments / remaining user text = **subject only**.

```bash
bash "$ENGINE" architecture \
  --prompt "<user subject>" \
  --image "./tzai-architecture-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Isometric or clean technical architecture diagram: clients, gateway, services, databases, queues, cloud boundary, muted tech blues/grays, white background, no unreadable garble text.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
