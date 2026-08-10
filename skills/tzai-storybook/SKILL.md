---
name: tzai-storybook
description: >
  Generate Storybook art (绘本插画) images via TaoziAPI using tzai-image kind=storybook.
  Use when the user runs /tzai-storybook, /tzai-image storybook, or asks for 绘本插画 / Storybook art.
  Category: photo (影像与插画). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "绘本插画 · 影像与插画"
  tzai-kind: "storybook"
  tzai-category: "photo"
---

# tzai-storybook — 绘本插画

Slash: **`/tzai-storybook`** · Engine kind: **`storybook`** · Category: **影像与插画** · Default AR: **1:1**

Thin slash entry for the `storybook` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" storybook \
  --prompt "<user subject>" \
  --image "./tzai-storybook-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Children's storybook illustration, soft watercolor or gentle paint, pastel friendly, narrative charm.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
