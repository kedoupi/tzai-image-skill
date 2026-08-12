---
name: tzai-xhs-cover
description: >
  Generate XHS cover (小红书封面) images via TaoziAPI using tzai-image kind=xhs-cover.
  Use when the user runs /tzai-xhs-cover, /tzai-image xhs-cover, or asks for 小红书封面 / XHS cover.
  Category: social (社交种草). Default aspect 3:4. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.1"
  tzai-generated-by: tzai-image-skill
  short-description: "小红书封面 · 社交种草"
  tzai-kind: "xhs-cover"
  tzai-category: "social"
  tzai-slash: "plan-c"
---

# tzai-xhs-cover — 小红书封面

Slash: **`/tzai-xhs-cover`** · Engine kind: **`xhs-cover`** · Category: **社交种草** · Default AR: **3:4**

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
bash "$ENGINE" xhs-cover \
  --prompt "<user subject>" \
  --image "./tzai-xhs-cover-$(date +%Y%m%d-%H%M%S).png"
```

### P0 matrix (style × layout)

```bash
bash "$ENGINE" presets xhs
bash "$ENGINE" xhs-cover --style notion --layout dense --prompt "<subject>" --image out.png
bash "$ENGINE" xhs-cover --preset knowledge-card --prompt "<subject>" --image out.png
```

Series workflow: engine `references/workflows/xhs-series.md`.

## Kind direction

Xiaohongshu FEED COVER card (not product catalog photo): 3:4 social thumbnail designed to stop scrolling, bold graphic cover layout with large primary title zone (short Chinese title ok, max ~8 chars if any) plus optional subtitle band, strong visual hierarchy like a magazine cover or knowledge poster, high-contrast color blocks or refined lifestyle scene as BACKGROUND support only (not a white-studio e-commerce product shot), punchy composition for mobile feed, design-agency social creative. Readable Chinese only in title zone when used; no garbled text, minimal clutter, no watermark, no long paragraphs.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-social` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-social`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
