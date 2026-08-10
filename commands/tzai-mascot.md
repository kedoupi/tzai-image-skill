---
description: 吉祥物 / 3D / brand mascot via TaoziAPI (kind=mascot)
argument-hint: "prompt…"
---

# /tzai-mascot

Generate **吉祥物** (3D / brand mascot) with TaoziAPI.

**Kind:** `mascot` · **Category:** 品牌识别 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> mascot --prompt "<subject>" --image "./tzai-mascot-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
