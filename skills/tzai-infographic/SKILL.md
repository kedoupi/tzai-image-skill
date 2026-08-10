---
name: tzai-infographic
description: >
  Generate Infographic (信息图) images via TaoziAPI using tzai-image kind=infographic.
  Use when the user runs /tzai-infographic, /tzai-image infographic, or asks for 信息图 / Infographic.
  Category: diagram (结构图示). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "信息图 · 结构图示"
  tzai-kind: "infographic"
  tzai-category: "diagram"
---

# tzai-infographic — 信息图

Slash: **`/tzai-infographic`** · Engine kind: **`infographic`** · Category: **结构图示** · Default AR: **16:9**

Thin slash entry for the `infographic` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" infographic \
  --prompt "<user subject>" \
  --image "./tzai-infographic-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Publication-ready infographic, strong layout hierarchy, icon headers, metric-friendly cards or steps, clean corporate or editorial style, white background, avoid dense fake paragraphs.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
