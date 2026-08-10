---
name: tzai-banner
description: >
  Generate Ad / campaign banner (投放Banner) images via TaoziAPI using tzai-image kind=banner.
  Use when the user runs /tzai-banner, /tzai-image banner, or asks for 投放Banner / Ad / campaign banner.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "投放Banner · 市场内容"
  tzai-kind: "banner"
  tzai-category: "marketing"
---

# tzai-banner — 投放Banner

Slash: **`/tzai-banner`** · Engine kind: **`banner`** · Category: **市场内容** · Default AR: **16:9**

Thin slash entry for the `banner` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" banner \
  --prompt "<user subject>" \
  --image "./tzai-banner-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Digital marketing campaign banner, high contrast, bold composition, ad-creative quality, no brand wordmarks unless user provides.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
