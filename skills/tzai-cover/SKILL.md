---
name: tzai-cover
description: >
  Generate Article cover (文章封面) images via TaoziAPI using tzai-image kind=cover.
  Use when the user runs /tzai-cover, /tzai-image cover, or asks for 文章封面 / Article cover.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "文章封面 · 市场内容"
  tzai-kind: "cover"
  tzai-category: "marketing"
---

# tzai-cover — 文章封面

Slash: **`/tzai-cover`** · Engine kind: **`cover`** · Category: **市场内容** · Default AR: **16:9**

Thin slash entry for the `cover` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" cover \
  --prompt "<user subject>" \
  --image "./tzai-cover-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Editorial article cover image, cinematic or clean graphic, strong focal subject, space for title, blog/WeChat header ready.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
