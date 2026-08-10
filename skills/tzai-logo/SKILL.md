---
name: tzai-logo
description: >
  Generate Logo / monogram (Logo标志) images via TaoziAPI using tzai-image kind=logo.
  Use when the user runs /tzai-logo, /tzai-image logo, or asks for Logo标志 / Logo / monogram.
  Category: brand (品牌识别). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.5.4"
  tzai-generated-by: tzai-image-skill
  short-description: "Logo标志 · 品牌识别"
  tzai-kind: "logo"
  tzai-category: "brand"
  tzai-slash: "plan-c"
---

# tzai-logo — Logo标志

Slash: **`/tzai-logo`** · Engine kind: **`logo`** · Category: **品牌识别** · Default AR: **16:9**

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
bash "$ENGINE" logo \
  --prompt "<user subject>" \
  --image "./tzai-logo-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Premium brand logo / monogram board on pure white, geometric memorable mark, razor-sharp vector edges, ample negative space, Swiss identity-system discipline, subtle soft shadow only under the mark, no slogan unless user asks, no watermark, corporate identity final-art quality.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-brand` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-brand`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
