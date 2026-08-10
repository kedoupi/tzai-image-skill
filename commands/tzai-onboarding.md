---
description: 引导主视觉 / Onboarding hero via TaoziAPI (kind=onboarding)
argument-hint: "prompt…"
---

# /tzai-onboarding

Generate **引导主视觉** (Onboarding hero) with TaoziAPI.

**Kind:** `onboarding` · **Category:** 产品设计 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> onboarding --prompt "<subject>" --image "./tzai-onboarding-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
