---
name: tzai-social
description: >
  Category hub for 社交种草 (social) image generation via TaoziAPI.
  Use when the user runs /tzai-social or wants any social visual: xhs, xhs-cover, wechat.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. xhs <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "社交种草分类 · social"
  tzai-category: "social"
---

# /tzai-social — 社交种草

Kinds: `xhs` `xhs-cover` `wechat`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
