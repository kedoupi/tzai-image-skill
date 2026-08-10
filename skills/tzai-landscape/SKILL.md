---
name: tzai-landscape
description: >
  Generate Landscape / hero (风光头图) images via TaoziAPI using tzai-image kind=landscape.
  Use when the user runs /tzai-landscape, /tzai-image landscape, or asks for 风光头图 / Landscape / hero.
  Category: photo (影像与插画). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "风光头图 · 影像与插画"
  tzai-kind: "landscape"
  tzai-category: "photo"
---

# tzai-landscape — 风光头图

Slash: **`/tzai-landscape`** · Engine kind: **`landscape`** · Category: **影像与插画** · Default AR: **16:9**

Thin slash entry for the `landscape` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" landscape \
  --prompt "<user subject>" \
  --image "./tzai-landscape-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Cinematic landscape or wide hero photo, strong atmosphere, National Geographic or film still quality.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
