---
name: tzai-wireframe
description: >
  Generate Mobile wireframe (线框图) images via TaoziAPI using tzai-image kind=wireframe.
  Use when the user runs /tzai-wireframe, /tzai-image wireframe, or asks for 线框图 / Mobile wireframe.
  Category: product (产品设计). Default aspect 9:16. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "线框图 · 产品设计"
  tzai-kind: "wireframe"
  tzai-category: "product"
---

# tzai-wireframe — 线框图

Slash: **`/tzai-wireframe`** · Engine kind: **`wireframe`** · Category: **产品设计** · Default AR: **9:16**

Thin slash entry for the `wireframe` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" wireframe \
  --prompt "<user subject>" \
  --image "./tzai-wireframe-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Low-fidelity mobile wireframe screens, gray boxes and lines, UX documentation style, multiple frames if useful, white background.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
