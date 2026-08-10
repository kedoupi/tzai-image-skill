---
name: tzai-diagram
description: >
  Category hub for 结构图示 (diagram) image generation via TaoziAPI.
  Use when the user runs /tzai-diagram or wants any diagram visual: flowchart, architecture, mindmap, diagram, infographic, dataviz.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. flowchart <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "结构图示分类 · diagram"
  tzai-category: "diagram"
---

# /tzai-diagram — 结构图示

Kinds: `flowchart` `architecture` `mindmap` `diagram` `infographic` `dataviz`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
