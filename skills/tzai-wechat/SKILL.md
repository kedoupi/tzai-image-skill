---
name: tzai-wechat
description: >
  Generate WeChat article visual (微信配图) images via TaoziAPI using tzai-image kind=wechat.
  Use when the user runs /tzai-wechat, /tzai-image wechat, or asks for 微信配图 / WeChat article visual.
  Category: social (社交种草). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.4"
  tzai-generated-by: tzai-image-skill
  short-description: "微信配图 · 社交种草"
  tzai-kind: "wechat"
  tzai-category: "social"
  tzai-slash: "plan-c"
---

# tzai-wechat — 微信配图

Slash: **`/tzai-wechat`** · Engine kind: **`wechat`** · Category: **社交种草** · Default AR: **16:9**

High-frequency scene entry (Plan C). Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
  echo "Install engine: npx skills add kedoupi/tzai-image-skill -g --skill tzai-image -y" >&2
  exit 1
fi
```

## Route before running

Determine the requested outcome before selecting a command:

- One independently useful image → continue with this kind.
- A complete note/article, multi-screen flow, deck, campaign, brand system, or coordinated series → do not collapse it into one image. Read the engine's `references/workflows/index.tsv` and follow the matching project guide, including plan approval and one-anchor approval.

The user does not need to know the kind, pattern, matrix, or CLI.

## Run a single asset

Slash arguments / remaining user text = **subject only** (art direction is injected by kind).

```bash
bash "$ENGINE" wechat \
  --prompt "<user subject>" \
  --image "./tzai-wechat-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Premium WeChat Official Account header/illustration, soft professional teal-blue editorial style, refined composition, high-end Chinese tech-media aesthetic. Prefer short readable Chinese if any on-image text; no garbled characters, no dense fake paragraphs, no watermark.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-social` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-social`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
