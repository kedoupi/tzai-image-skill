---
name: tzai-poster
description: >
  Generate Vertical poster (竖版海报) images via TaoziAPI using tzai-image kind=poster.
  Use when the user runs /tzai-poster, /tzai-image poster, or asks for 竖版海报 / Vertical poster.
  Category: marketing (市场内容). Default aspect 9:16. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "竖版海报 · 市场内容"
  tzai-kind: "poster"
  tzai-category: "marketing"
---

# tzai-poster — 竖版海报

Slash: **`/tzai-poster`** · Engine kind: **`poster`** · Category: **市场内容** · Default AR: **9:16**

Thin slash entry for the `poster` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" poster \
  --prompt "<user subject>" \
  --image "./tzai-poster-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Vertical poster / story creative, strong focal point, social-ready 9:16, minimal text areas, high visual impact.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
