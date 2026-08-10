---
name: tzai-brand
description: >
  Category hub for 品牌识别 (brand) image generation via TaoziAPI.
  Use when the user runs /tzai-brand or wants any brand visual: icon, logo, moodboard, mascot, badge, avatar.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. icon <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.4.0"
  short-description: "品牌识别分类 · brand"
  tzai-category: "brand"
  tzai-slash: "plan-c-hub"
---

# /tzai-brand — 品牌识别 (Brand identity)

**Category hub** (Plan C). Do **not** invent a new kind — pick one below, then generate.

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
