---
name: tzai-logo
description: >
  Generate Logo / monogram (Logo标志) images via TaoziAPI using tzai-image kind=logo.
  Use when the user runs /tzai-logo, /tzai-image logo, or asks for Logo标志 / Logo / monogram.
  Category: brand (品牌识别). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "Logo标志 · 品牌识别"
  tzai-kind: "logo"
  tzai-category: "brand"
---

# tzai-logo — Logo标志

Slash: **`/tzai-logo`** · Engine kind: **`logo`** · Category: **品牌识别** · Default AR: **16:9**

Thin slash entry for the `logo` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" logo \
  --prompt "<user subject>" \
  --image "./tzai-logo-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Brand logo / monogram design, geometric, memorable, flat vector or clean mark, ample negative space, professional identity system, no slogan text unless user asks.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
