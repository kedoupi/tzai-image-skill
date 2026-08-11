---
description: Logo标志 / Logo / monogram via TaoziAPI (kind=logo)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-logo

Generate **Logo标志** (Logo / monogram) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `logo` · **Category:** 品牌识别 · **AR:** 16:9

## Steps

1. If the request is a coordinated project, route through the engine workflow catalog instead of this single-asset wrapper.
2. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
3. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
4. Ensure `TZAI_API_KEY` or `tzai-image init`
5. For a single asset, slash args = **subject only**
6. Run:

```bash
bash <engine> logo --prompt "<subject>" --image "./tzai-logo-$(date +%Y%m%d-%H%M%S).png"
```

7. Report output path. Default model: **gpt-image-2**.
