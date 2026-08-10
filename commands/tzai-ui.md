---
description: UI仪表盘 / UI dashboard mock via TaoziAPI (kind=ui)
argument-hint: "prompt…"
---

# /tzai-ui

Generate **UI仪表盘** (UI dashboard mock) with TaoziAPI.

**Kind:** `ui` · **Category:** 产品设计 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> ui --prompt "<subject>" --image "./tzai-ui-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
