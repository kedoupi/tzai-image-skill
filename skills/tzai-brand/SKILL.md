---
name: tzai-brand
description: >
  Category hub for 品牌识别 (brand) image generation via TaoziAPI.
  Use when the user runs /tzai-brand or wants any brand visual: icon, logo, moodboard, mascot, badge, avatar.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. icon <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "品牌识别分类 · brand"
  tzai-category: "brand"
---

# /tzai-brand — 品牌识别

Kinds: `icon` `logo` `moodboard` `mascot` `badge` `avatar`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
