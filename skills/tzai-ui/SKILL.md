---
name: tzai-ui
description: >
  Generate UI dashboard mock (UI仪表盘) images via TaoziAPI using tzai-image kind=ui.
  Use when the user runs /tzai-ui, /tzai-image ui, or asks for UI仪表盘 / UI dashboard mock.
  Category: product (产品设计). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.4"
  tzai-generated-by: tzai-image-skill
  short-description: "UI仪表盘 · 产品设计"
  tzai-kind: "ui"
  tzai-category: "product"
  tzai-slash: "plan-c"
---

# tzai-ui — UI仪表盘

Slash: **`/tzai-ui`** · Engine kind: **`ui`** · Category: **产品设计** · Default AR: **16:9**

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
bash "$ENGINE" ui \
  --prompt "<user subject>" \
  --image "./tzai-ui-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Ultra-premium SaaS dashboard UI mock, Linear/Stripe design language, polished light or dark mode, 8pt spacing, cards charts KPIs, soft shadows, subtle browser chrome optional, Figma-final quality, no real PII, no watermark.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-product` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-product`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
