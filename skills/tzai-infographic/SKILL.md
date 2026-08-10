---
name: tzai-infographic
description: >
  Generate Infographic (信息图) images via TaoziAPI using tzai-image kind=infographic.
  Use when the user runs /tzai-infographic, /tzai-image infographic, or asks for 信息图 / Infographic.
  Category: diagram (结构图示). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.5.4"
  tzai-generated-by: tzai-image-skill
  short-description: "信息图 · 结构图示"
  tzai-kind: "infographic"
  tzai-category: "diagram"
  tzai-slash: "plan-c"
---

# tzai-infographic — 信息图

Slash: **`/tzai-infographic`** · Engine kind: **`infographic`** · Category: **结构图示** · Default AR: **16:9**

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
bash "$ENGINE" infographic \
  --prompt "<user subject>" \
  --image "./tzai-infographic-$(date +%Y%m%d-%H%M%S).png"
```

### P0 matrix (layout × style)

```bash
bash "$ENGINE" presets infographic
bash "$ENGINE" infographic --layout funnel --style tech-schematic --prompt "<subject>" --image out.png
```

## Kind direction

Publication-ready infographic, modular grid, strong hierarchy, icon headers, metric cards or steps, Stripe/Linear editorial polish, slate-teal corporate palette, white background, avoid dense fake paragraphs, no watermark.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-diagram` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-diagram`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
