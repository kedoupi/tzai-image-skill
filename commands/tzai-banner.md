---
description: 投放Banner / Ad / campaign banner via TaoziAPI (kind=banner)
argument-hint: "prompt…"
---

# /tzai-banner

Generate **投放Banner** (Ad / campaign banner) with TaoziAPI.

**Kind:** `banner` · **Category:** 市场内容 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> banner --prompt "<subject>" --image "./tzai-banner-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
