---
description: 线框图 / Mobile wireframe via TaoziAPI (kind=wireframe)
argument-hint: "prompt…"
---

# /tzai-wireframe

Generate **线框图** (Mobile wireframe) with TaoziAPI.

**Kind:** `wireframe` · **Category:** 产品设计 · **AR:** 9:16

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> wireframe --prompt "<subject>" --image "./tzai-wireframe-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
