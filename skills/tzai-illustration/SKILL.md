---
name: tzai-illustration
description: >
  Generate Illustration (通用插画) images via TaoziAPI using tzai-image kind=illustration.
  Use when the user runs /tzai-illustration, /tzai-image illustration, or asks for 通用插画 / Illustration.
  Category: photo (影像与插画). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "通用插画 · 影像与插画"
  tzai-kind: "illustration"
  tzai-category: "photo"
---

# tzai-illustration — 通用插画

Slash: **`/tzai-illustration`** · Engine kind: **`illustration`** · Category: **影像与插画** · Default AR: **1:1**

Thin slash entry for the `illustration` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" illustration \
  --prompt "<user subject>" \
  --image "./tzai-illustration-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

High-quality illustration, coherent style, clean edges, publication ready.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
