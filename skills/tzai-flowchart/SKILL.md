---
name: tzai-flowchart
description: >
  Generate Flowchart / process (流程图) images via TaoziAPI using tzai-image kind=flowchart.
  Use when the user runs /tzai-flowchart, /tzai-image flowchart, or asks for 流程图 / Flowchart / process.
  Category: diagram (结构图示). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "流程图 · 结构图示"
  tzai-kind: "flowchart"
  tzai-category: "diagram"
---

# tzai-flowchart — 流程图

Slash: **`/tzai-flowchart`** · Engine kind: **`flowchart`** · Category: **结构图示** · Default AR: **16:9**

Thin slash entry for the `flowchart` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" flowchart \
  --prompt "<user subject>" \
  --image "./tzai-flowchart-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Professional process flowchart, left-to-right or top-down steps, clean arrows, rounded nodes, consulting-slide clarity, corporate palette, white background, minimal readable labels only if essential.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
