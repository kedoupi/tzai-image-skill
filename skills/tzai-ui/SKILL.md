---
name: tzai-ui
description: >
  Generate UI dashboard mock (UI仪表盘) images via TaoziAPI using tzai-image kind=ui.
  Use when the user runs /tzai-ui, /tzai-image ui, or asks for UI仪表盘 / UI dashboard mock.
  Category: product (产品设计). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "UI仪表盘 · 产品设计"
  tzai-kind: "ui"
  tzai-category: "product"
---

# tzai-ui — UI仪表盘

Slash: **`/tzai-ui`** · Engine kind: **`ui`** · Category: **产品设计** · Default AR: **16:9**

Thin slash entry for the `ui` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" ui \
  --prompt "<user subject>" \
  --image "./tzai-ui-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

SaaS product UI mock dashboard, polished light or dark mode, cards charts KPIs, Figma-like quality, browser chrome subtle, no real PII or confidential metrics text.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
