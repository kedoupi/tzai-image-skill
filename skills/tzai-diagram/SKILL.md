---
name: tzai-diagram
description: >
  Category hub for 结构图示 (diagram) image generation via TaoziAPI.
  Use when the user runs /tzai-diagram or wants any diagram visual: flowchart, architecture, mindmap, diagram, infographic, dataviz.
  Infer a single kind or route a coordinated project through the engine workflow catalog. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. flowchart <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.5"
  tzai-generated-by: tzai-image-skill
  short-description: "结构图示分类 · diagram"
  tzai-category: "diagram"
  tzai-slash: "plan-c-hub"
---

# /tzai-diagram — 结构图示 (Diagrams & structure)

**Category hub** (Plan C). Infer the user's outcome; do not make the user learn this taxonomy.

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

1. Distinguish one asset from a coordinated project.
2. For a project, read the engine's `references/workflows/index.tsv`, select the matching guide, and follow both approval gates.
3. For one asset, infer the kind from intent; ask once only if ambiguity materially changes the result.
4. Compile slots into `--prompt` using the engine `references/patterns/compile-guide.md` (not a one-line subject unless the user asked for raw):

```bash
bash "$ENGINE" <kind> \
  --prompt "<compiled visual brief>" \
  --image "./tzai-<kind>-$(date +%Y%m%d-%H%M%S).png"
```

## Teaching tip

Use this hub when the user expresses a broad outcome. Kinds and direct slashes are internal shortcuts; present a recommendation, not a command menu.

## See also

- Engine `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
