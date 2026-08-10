---
name: tzai-mascot
description: >
  Generate 3D / brand mascot (吉祥物) images via TaoziAPI using tzai-image kind=mascot.
  Use when the user runs /tzai-mascot, /tzai-image mascot, or asks for 吉祥物 / 3D / brand mascot.
  Category: brand (品牌识别). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "吉祥物 · 品牌识别"
  tzai-kind: "mascot"
  tzai-category: "brand"
---

# tzai-mascot — 吉祥物

Slash: **`/tzai-mascot`** · Engine kind: **`mascot`** · Category: **品牌识别** · Default AR: **1:1**

Thin slash entry for the `mascot` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" mascot \
  --prompt "<user subject>" \
  --image "./tzai-mascot-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Brand mascot character, cute but professional, soft studio lighting, product IP style, single character centered, clean background.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
