---
name: tzai-marketing
description: >
  Category hub for 市场内容 (marketing) image generation via TaoziAPI.
  Use when the user runs /tzai-marketing or wants any marketing visual: slide, banner, email-header, cover, poster.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. slide <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "市场内容分类 · marketing"
  tzai-category: "marketing"
---

# /tzai-marketing — 市场内容

Kinds: `slide` `banner` `email-header` `cover` `poster`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
