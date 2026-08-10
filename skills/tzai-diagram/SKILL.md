---
name: tzai-diagram
description: >
  Category hub for 结构图示 (diagram) image generation via TaoziAPI.
  Use when the user runs /tzai-diagram or wants any diagram visual: flowchart, architecture, mindmap, diagram, infographic, dataviz.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. flowchart <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.4.0"
  short-description: "结构图示分类 · diagram"
  tzai-category: "diagram"
  tzai-slash: "plan-c-hub"
---

# /tzai-diagram — 结构图示 (Diagrams & structure)

**Category hub** (Plan C). Do **not** invent a new kind — pick one below, then generate.

Flowcharts, architecture, mind maps, infographics.

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

## Kinds in this category

| Kind | 中文 | AR | How to invoke |
| --- | --- | --- | --- |
| `flowchart` | 流程图 | 16:9 | `/tzai-flowchart` |
| `architecture` | 架构图 | 16:9 | `/tzai-architecture` |
| `mindmap` | 思维导图 | 1:1 | `/tzai-image mindmap` |
| `diagram` | 技术示意图 | 16:9 | `/tzai-image diagram` |
| `infographic` | 信息图 | 16:9 | `/tzai-infographic` |
| `dataviz` | 数据可视化 | 16:9 | `/tzai-image dataviz` |

- **Direct slash (high-freq):** `/tzai-flowchart`, `/tzai-architecture`, `/tzai-infographic`
- **Long-tail (via hub / engine):** `mindmap`, `diagram`, `dataviz`

## Agent flow

1. If user already named a kind in the table → use it.
2. Else infer from intent (e.g. 图标→`icon`, 流程图→`flowchart`) or ask once.
3. Subject only in `--prompt`:

```bash
bash "$ENGINE" <kind> \
  --prompt "<subject>" \
  --image "./tzai-<kind>-$(date +%Y%m%d-%H%M%S).png"
```

## Teaching tip

Use this hub when the user says a **broad** need (“做点品牌图”“来张结构图”).  
If they already know the scene (“小红书图卡”“架构图”), prefer the **direct slash** for fewer turns.

## See also

- Engine `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
