---
name: tzai-product
description: >
  Category hub for 产品设计 (product) image generation via TaoziAPI.
  Use when the user runs /tzai-product or wants any product visual: ui, wireframe, empty-state, onboarding.
  Infer a single kind or route a coordinated project through the engine workflow catalog. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. ui <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.6.0"
  tzai-generated-by: tzai-image-skill
  short-description: "产品设计分类 · product"
  tzai-category: "product"
  tzai-slash: "plan-c-hub"
---

# /tzai-product — 产品设计 (Product design)

**Category hub** (Plan C). Infer the user's outcome; do not make the user learn this taxonomy.

UI mocks, wireframes, empty states, onboarding.

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
| `ui` | UI仪表盘 | 16:9 | `/tzai-ui` |
| `wireframe` | 线框图 | 9:16 | `/tzai-image wireframe` |
| `empty-state` | 空状态插画 | 1:1 | `/tzai-image empty-state` |
| `onboarding` | 引导主视觉 | 16:9 | `/tzai-image onboarding` |

- **Direct slash (high-freq):** `/tzai-ui`
- **Long-tail (via hub / engine):** `wireframe`, `empty-state`, `onboarding`

## Agent flow

1. Distinguish one asset from a coordinated project.
2. For a project, read the engine's `references/workflows/index.tsv`, select the matching guide, and follow both approval gates.
3. For one asset, infer the kind from intent; ask once only if ambiguity materially changes the result.
4. Put the concise visual brief in `--prompt`:

```bash
bash "$ENGINE" <kind> \
  --prompt "<subject>" \
  --image "./tzai-<kind>-$(date +%Y%m%d-%H%M%S).png"
```

## Teaching tip

Use this hub when the user expresses a broad outcome. Kinds and direct slashes are internal shortcuts; present a recommendation, not a command menu.

## See also

- Engine `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
