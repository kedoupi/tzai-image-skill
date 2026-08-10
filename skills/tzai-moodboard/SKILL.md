---
name: tzai-moodboard
description: >
  Generate Brand mood board (品牌情绪板) images via TaoziAPI using tzai-image kind=moodboard.
  Use when the user runs /tzai-moodboard, /tzai-image moodboard, or asks for 品牌情绪板 / Brand mood board.
  Category: brand (品牌识别). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "品牌情绪板 · 品牌识别"
  tzai-kind: "moodboard"
  tzai-category: "brand"
---

# tzai-moodboard — 品牌情绪板

Slash: **`/tzai-moodboard`** · Engine kind: **`moodboard`** · Category: **品牌识别** · Default AR: **16:9**

Thin slash entry for the `moodboard` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" moodboard \
  --prompt "<user subject>" \
  --image "./tzai-moodboard-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Brand mood board collage: color chips, textures, typography as abstract bars, lifestyle refs, design-agency aesthetic, cohesive palette.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
