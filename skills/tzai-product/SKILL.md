---
name: tzai-product
description: >
  Category hub for 产品设计 (product) image generation via TaoziAPI.
  Use when the user runs /tzai-product or wants any product visual: ui, wireframe, empty-state, onboarding.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. ui <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "产品设计分类 · product"
  tzai-category: "product"
---

# /tzai-product — 产品设计

Kinds: `ui` `wireframe` `empty-state` `onboarding`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
