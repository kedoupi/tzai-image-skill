---
name: tzai-wechat
description: >
  Generate WeChat article visual (微信配图) images via TaoziAPI using tzai-image kind=wechat.
  Use when the user runs /tzai-wechat, /tzai-image wechat, or asks for 微信配图 / WeChat article visual.
  Category: social (社交种草). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "微信配图 · 社交种草"
  tzai-kind: "wechat"
  tzai-category: "social"
---

# tzai-wechat — 微信配图

Slash: **`/tzai-wechat`** · Engine kind: **`wechat`** · Category: **社交种草** · Default AR: **16:9**

Thin slash entry for the `wechat` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" wechat \
  --prompt "<user subject>" \
  --image "./tzai-wechat-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

WeChat Official Account article illustration or header, clean Chinese content-platform aesthetic, readable composition, soft professional colors.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
