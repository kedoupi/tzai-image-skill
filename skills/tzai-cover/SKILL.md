---
name: tzai-cover
description: >
  Generate Article cover (文章封面) images via TaoziAPI using tzai-image kind=cover.
  Use when the user runs /tzai-cover, /tzai-image cover, or asks for 文章封面 / Article cover.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.6.1"
  tzai-generated-by: tzai-image-skill
  short-description: "文章封面 · 市场内容"
  tzai-kind: "cover"
  tzai-category: "marketing"
  tzai-slash: "plan-c"
---

# tzai-cover — 文章封面

Slash: **`/tzai-cover`** · Engine kind: **`cover`** · Category: **市场内容** · Default AR: **16:9**

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
bash "$ENGINE" cover \
  --prompt "<user subject>" \
  --image "./tzai-cover-$(date +%Y%m%d-%H%M%S).png"
```

### P0 dimensions (type × palette × rendering × text × mood)

```bash
bash "$ENGINE" presets cover
bash "$ENGINE" cover --type hero --palette dark --mood bold --text none --prompt "<subject>" --image out.png
```

## Kind direction

Cinematic editorial article cover, strong atmosphere, refined light trails or focal subject, large title-safe empty region, Stripe/Vercel-blog hero quality, minimal or no on-image text, no watermark.

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-marketing` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-marketing`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
