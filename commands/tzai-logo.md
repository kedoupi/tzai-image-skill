---
description: Logo标志 / Logo / monogram via TaoziAPI (kind=logo)
argument-hint: "prompt…"
---

# /tzai-logo

Generate **Logo标志** (Logo / monogram) with TaoziAPI.

**Kind:** `logo` · **Category:** 品牌识别 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> logo --prompt "<subject>" --image "./tzai-logo-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
