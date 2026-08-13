---
name: tzai-photo
description: >
  Category hub for 影像插画 (photo) image generation via TaoziAPI.
  Use when the user runs /tzai-photo or wants any photo visual: product-photo, photo, landscape, illustration, storybook, food.
  Infer a single kind or route a coordinated project through the engine workflow catalog. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. product-photo <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.5"
  tzai-generated-by: tzai-image-skill
  short-description: "影像插画分类 · photo"
  tzai-category: "photo"
  tzai-slash: "plan-c-hub"
---

# /tzai-photo — 影像插画 (Photo & illustration)

**Category hub** (Plan C). Infer the user's outcome; do not make the user learn this taxonomy.

Product, photo, landscape, storybook, food.

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
| `product-photo` | 商品摄影 | 1:1 | `/tzai-image product-photo` |
| `photo` | 通用摄影 | 1:1 | `/tzai-image photo` |
| `landscape` | 风光头图 | 16:9 | `/tzai-image landscape` |
| `illustration` | 通用插画 | 1:1 | `/tzai-image illustration` |
| `storybook` | 绘本插画 | 1:1 | `/tzai-image storybook` |
| `food` | 美食生活 | 1:1 | `/tzai-image food` |

- **Direct slash (high-freq):** (none)
- **Long-tail (via hub / engine):** `product-photo`, `photo`, `landscape`, `illustration`, `storybook`, `food`

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
