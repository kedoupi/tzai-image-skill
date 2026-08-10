---
name: tzai-xhs
description: >
  Generate Xiaohongshu / 小红书 card (小红书图卡) images via TaoziAPI using tzai-image kind=xhs.
  Use when the user runs /tzai-xhs, /tzai-image xhs, or asks for 小红书图卡 / Xiaohongshu / 小红书 card.
  Category: social (社交种草). Default aspect 3:4. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.4.0"
  short-description: "小红书图卡 · 社交种草"
  tzai-kind: "xhs"
  tzai-category: "social"
  tzai-slash: "plan-c"
---

# tzai-xhs — 小红书图卡

Slash: **`/tzai-xhs`** · Engine kind: **`xhs`** · Category: **社交种草** · Default AR: **3:4**

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

## Run

Slash arguments / remaining user text = **subject only** (art direction is injected by kind).

```bash
bash "$ENGINE" xhs \
  --prompt "<user subject>" \
  --image "./tzai-xhs-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Xiaohongshu (小红书) style image card: high engagement social infographic, bold title area, clean hierarchy, lifestyle or knowledge-share aesthetic, Chinese social feed friendly, punchy colors, avoid messy watermarks.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-social` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-social`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
