---
name: tzai-brand
description: >
  Category hub for 品牌识别 (brand) image generation via TaoziAPI.
  Use when the user runs /tzai-brand or wants any brand visual: icon, logo, moodboard, mascot, badge, avatar.
  Infer a single kind or route a coordinated project through the engine workflow catalog. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. icon <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.1"
  tzai-generated-by: tzai-image-skill
  short-description: "品牌识别分类 · brand"
  tzai-category: "brand"
  tzai-slash: "plan-c-hub"
---

# /tzai-brand — 品牌识别 (Brand identity)

**Category hub** (Plan C). Infer the user's outcome; do not make the user learn this taxonomy.

Icons, logos, mascots, badges, avatars, mood boards.

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
| `icon` | App图标 | 1:1 | `/tzai-icon` |
| `logo` | Logo标志 | 16:9 | `/tzai-logo` |
| `moodboard` | 品牌情绪板 | 16:9 | `/tzai-image moodboard` |
| `mascot` | 吉祥物 | 1:1 | `/tzai-image mascot` |
| `badge` | 徽章贴纸 | 1:1 | `/tzai-image badge` |
| `avatar` | 职业头像 | 1:1 | `/tzai-image avatar` |

- **Direct slash (high-freq):** `/tzai-icon`, `/tzai-logo`
- **Long-tail (via hub / engine):** `moodboard`, `mascot`, `badge`, `avatar`

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
