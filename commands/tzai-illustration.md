---
description: 通用插画 / Illustration via TaoziAPI (kind=illustration)
argument-hint: "prompt…"
---

# /tzai-illustration

Generate **通用插画** (Illustration) with TaoziAPI.

**Kind:** `illustration` · **Category:** 影像与插画 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> illustration --prompt "<subject>" --image "./tzai-illustration-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
