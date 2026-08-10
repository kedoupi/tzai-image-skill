---
name: tzai-mindmap
description: >
  Generate Mind map (思维导图) images via TaoziAPI using tzai-image kind=mindmap.
  Use when the user runs /tzai-mindmap, /tzai-image mindmap, or asks for 思维导图 / Mind map.
  Category: diagram (结构图示). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "思维导图 · 结构图示"
  tzai-kind: "mindmap"
  tzai-category: "diagram"
---

# tzai-mindmap — 思维导图

Slash: **`/tzai-mindmap`** · Engine kind: **`mindmap`** · Category: **结构图示** · Default AR: **1:1**

Thin slash entry for the `mindmap` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" mindmap \
  --prompt "<user subject>" \
  --image "./tzai-mindmap-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Clean mind map, center hub with radiating branches, soft node colors, thin connectors, workshop whiteboard clarity, white background.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
