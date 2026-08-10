---
name: tzai-social
description: >
  Category hub for 社交种草 (social) image generation via TaoziAPI.
  Use when the user runs /tzai-social or wants any social visual: xhs, xhs-cover, wechat.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. xhs <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.5.4"
  tzai-generated-by: tzai-image-skill
  short-description: "社交种草分类 · social"
  tzai-category: "social"
  tzai-slash: "plan-c-hub"
---

# /tzai-social — 社交种草 (Social content)

**Category hub** (Plan C). Do **not** invent a new kind — pick one below, then generate.

Xiaohongshu (小红书), WeChat visuals.

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
| `xhs` | 小红书图卡 | 3:4 | `/tzai-xhs` |
| `xhs-cover` | 小红书封面 | 3:4 | `/tzai-xhs-cover` |
| `wechat` | 微信配图 | 16:9 | `/tzai-wechat` |

- **Direct slash (high-freq):** `/tzai-xhs`, `/tzai-xhs-cover`, `/tzai-wechat`
- **Long-tail (via hub / engine):** (none)

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
