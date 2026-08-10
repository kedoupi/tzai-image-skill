---
name: tzai-photo
description: >
  Category hub for 影像插画 (photo) image generation via TaoziAPI.
  Use when the user runs /tzai-photo or wants any photo visual: product, photo, landscape, illustration, storybook, food.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. product <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "影像插画分类 · photo"
  tzai-category: "photo"
---

# /tzai-photo — 影像插画

Kinds: `product` `photo` `landscape` `illustration` `storybook` `food`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
