---
name: tzai-slide
description: >
  Generate Slide / deck cover (PPT封面) images via TaoziAPI using tzai-image kind=slide.
  Use when the user runs /tzai-slide, /tzai-image slide, or asks for PPT封面 / Slide / deck cover.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "PPT封面 · 市场内容"
  tzai-kind: "slide"
  tzai-category: "marketing"
---

# tzai-slide — PPT封面

Slash: **`/tzai-slide`** · Engine kind: **`slide`** · Category: **市场内容** · Default AR: **16:9**

Thin slash entry for the `slide` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" slide \
  --prompt "<user subject>" \
  --image "./tzai-slide-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Presentation title-slide background, premium consulting deck aesthetic, abstract geometry, leave space for title, no body text.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
