---
description: 美食生活 / Food / lifestyle via TaoziAPI (kind=food)
argument-hint: "prompt…"
---

# /tzai-food

Generate **美食生活** (Food / lifestyle) with TaoziAPI.

**Kind:** `food` · **Category:** 影像与插画 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> food --prompt "<subject>" --image "./tzai-food-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
