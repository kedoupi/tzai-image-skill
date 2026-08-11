---
name: tzai-slide
description: >
  Generate Slide / deck cover (PPT封面) images via TaoziAPI using tzai-image kind=slide.
  Use when the user runs /tzai-slide, /tzai-image slide, or asks for PPT封面 / Slide / deck cover.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.6.0"
  tzai-generated-by: tzai-image-skill
  short-description: "PPT封面 · 市场内容"
  tzai-kind: "slide"
  tzai-category: "marketing"
  tzai-slash: "plan-c"
---

# tzai-slide — PPT封面

Slash: **`/tzai-slide`** · Engine kind: **`slide`** · Category: **市场内容** · Default AR: **16:9**

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
bash "$ENGINE" slide \
  --prompt "<user subject>" \
  --image "./tzai-slide-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Premium consulting title-slide background, deep navy geometric planes, subtle gold hairline accents, vast empty center for title overlay, McKinsey deck aesthetic, no body text, no watermark.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-marketing` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-marketing`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
