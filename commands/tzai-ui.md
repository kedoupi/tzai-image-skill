---
description: UI仪表盘 / UI dashboard mock via TaoziAPI (kind=ui)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-ui

Generate **UI仪表盘** (UI dashboard mock) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `ui` · **Category:** 产品设计 · **AR:** 16:9

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> ui --prompt "<subject>" --image "./tzai-ui-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
