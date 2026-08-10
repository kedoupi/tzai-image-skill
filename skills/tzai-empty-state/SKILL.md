---
name: tzai-empty-state
description: >
  Generate Empty state (空状态插画) images via TaoziAPI using tzai-image kind=empty-state.
  Use when the user runs /tzai-empty-state, /tzai-image empty-state, or asks for 空状态插画 / Empty state.
  Category: product (产品设计). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "空状态插画 · 产品设计"
  tzai-kind: "empty-state"
  tzai-category: "product"
---

# tzai-empty-state — 空状态插画

Slash: **`/tzai-empty-state`** · Engine kind: **`empty-state`** · Category: **产品设计** · Default AR: **1:1**

Thin slash entry for the `empty-state` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" empty-state \
  --prompt "<user subject>" \
  --image "./tzai-empty-state-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Product empty-state illustration, friendly flat art, generous whitespace for UI copy, modern SaaS illustration, soft colors.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
