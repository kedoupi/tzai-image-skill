---
name: tzai-badge
description: >
  Generate Badge / sticker set (徽章贴纸) images via TaoziAPI using tzai-image kind=badge.
  Use when the user runs /tzai-badge, /tzai-image badge, or asks for 徽章贴纸 / Badge / sticker set.
  Category: brand (品牌识别). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "徽章贴纸 · 品牌识别"
  tzai-kind: "badge"
  tzai-category: "brand"
---

# tzai-badge — 徽章贴纸

Slash: **`/tzai-badge`** · Engine kind: **`badge`** · Category: **品牌识别** · Default AR: **1:1**

Thin slash entry for the `badge` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" badge \
  --prompt "<user subject>" \
  --image "./tzai-badge-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

UI achievement badge or sticker set, flat design, clean shapes, white or transparent-look background, gamefication asset style.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
