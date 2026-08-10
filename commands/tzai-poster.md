---
description: 竖版海报 / Vertical poster via TaoziAPI (kind=poster)
argument-hint: "prompt…"
---

# /tzai-poster

Generate **竖版海报** (Vertical poster) with TaoziAPI.

**Kind:** `poster` · **Category:** 市场内容 · **AR:** 9:16

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> poster --prompt "<subject>" --image "./tzai-poster-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
