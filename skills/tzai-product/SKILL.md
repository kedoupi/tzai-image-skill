---
name: tzai-product
description: >
  Category hub for 产品设计 (product) image generation via TaoziAPI.
  Use when the user runs /tzai-product or wants any product visual: ui, wireframe, empty-state, onboarding.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. ui <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.5.0"
  short-description: "产品设计分类 · product"
  tzai-category: "product"
  tzai-slash: "plan-c-hub"
---

# /tzai-product — 产品设计 (Product design)

**Category hub** (Plan C). Do **not** invent a new kind — pick one below, then generate.

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
