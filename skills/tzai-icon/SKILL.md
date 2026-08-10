---
name: tzai-icon
description: >
  Generate App icon (App图标) images via TaoziAPI using tzai-image kind=icon.
  Use when the user runs /tzai-icon, /tzai-image icon, or asks for App图标 / App icon.
  Category: brand (品牌识别). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.5.0"
  short-description: "App图标 · 品牌识别"
  tzai-kind: "icon"
  tzai-category: "brand"
  tzai-slash: "plan-c"
---

# tzai-icon — App图标

Slash: **`/tzai-icon`** · Engine kind: **`icon`** · Category: **品牌识别** · Default AR: **1:1**

High-frequency scene entry (Plan C). Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
  echo "Install engine: npx skills add kedoupi/tzai-image-skill -g --skill tzai-image -y" >&2
  exit 1
fi
```

## Run

Slash arguments / remaining user text = **subject only** (art direction is injected by kind).

```bash
bash "$ENGINE" icon \
  --prompt "<user subject>" \
  --image "./tzai-icon-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

App icon design, rounded square, flat vector, single clear metaphor, iOS/Android store ready, crisp edges, no text, no watermark, no fake UI chrome.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-brand` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-brand`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
