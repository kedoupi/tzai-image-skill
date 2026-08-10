---
name: tzai-avatar
description: >
  Generate Professional avatar (职业头像) images via TaoziAPI using tzai-image kind=avatar.
  Use when the user runs /tzai-avatar, /tzai-image avatar, or asks for 职业头像 / Professional avatar.
  Category: brand (品牌识别). Default aspect 1:1. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "职业头像 · 品牌识别"
  tzai-kind: "avatar"
  tzai-category: "brand"
---

# tzai-avatar — 职业头像

Slash: **`/tzai-avatar`** · Engine kind: **`avatar`** · Category: **品牌识别** · Default AR: **1:1**

Thin slash entry for the `avatar` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" avatar \
  --prompt "<user subject>" \
  --image "./tzai-avatar-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Professional avatar / team directory portrait illustration, soft studio light, solid simple background, not a real celebrity likeness.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
