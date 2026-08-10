---
description: 风光头图 / Landscape / hero via TaoziAPI (kind=landscape)
argument-hint: "prompt…"
---

# /tzai-landscape

Generate **风光头图** (Landscape / hero) with TaoziAPI.

**Kind:** `landscape` · **Category:** 影像与插画 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> landscape --prompt "<subject>" --image "./tzai-landscape-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
