---
name: tzai-food
description: >
  Generate Food / lifestyle (美食生活) images via TaoziAPI using tzai-image kind=food.
  Use when the user runs /tzai-food, /tzai-image food, or asks for 美食生活 / Food / lifestyle.
  Category: photo (影像与插画). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "美食生活 · 影像与插画"
  tzai-kind: "food"
  tzai-category: "photo"
---

# tzai-food — 美食生活

Slash: **`/tzai-food`** · Engine kind: **`food`** · Category: **影像与插画** · Default AR: **1:1**

Thin slash entry for the `food` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" food \
  --prompt "<user subject>" \
  --image "./tzai-food-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Food or lifestyle photography, appetizing light, shallow depth of field when appropriate, Instagram-quality.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
