---
name: tzai-dataviz
description: >
  Generate Data viz art (数据可视化) images via TaoziAPI using tzai-image kind=dataviz.
  Use when the user runs /tzai-dataviz, /tzai-image dataviz, or asks for 数据可视化 / Data viz art.
  Category: diagram (结构图示). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "数据可视化 · 结构图示"
  tzai-kind: "dataviz"
  tzai-category: "diagram"
---

# tzai-dataviz — 数据可视化

Slash: **`/tzai-dataviz`** · Engine kind: **`dataviz`** · Category: **结构图示** · Default AR: **16:9**

Thin slash entry for the `dataviz` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" dataviz \
  --prompt "<user subject>" \
  --image "./tzai-dataviz-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Abstract or semi-real data visualization aesthetic: charts, ribbons, constellation metrics, modern analytics look, no private real data, no tiny unreadable axes text.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
