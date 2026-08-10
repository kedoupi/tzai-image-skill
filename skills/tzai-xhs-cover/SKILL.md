---
name: tzai-xhs-cover
description: >
  Generate XHS cover (小红书封面) images via TaoziAPI using tzai-image kind=xhs-cover.
  Use when the user runs /tzai-xhs-cover, /tzai-image xhs-cover, or asks for 小红书封面 / XHS cover.
  Category: social (社交种草). Default aspect 3:4. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "小红书封面 · 社交种草"
  tzai-kind: "xhs-cover"
  tzai-category: "social"
---

# tzai-xhs-cover — 小红书封面

Slash: **`/tzai-xhs-cover`** · Engine kind: **`xhs-cover`** · Category: **社交种草** · Default AR: **3:4**

Thin slash entry for the `xhs-cover` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" xhs-cover \
  --prompt "<user subject>" \
  --image "./tzai-xhs-cover-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Xiaohongshu cover thumbnail, eye-catching subject, high contrast, scroll-stopping, 3:4 feed ratio, minimal clutter.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
