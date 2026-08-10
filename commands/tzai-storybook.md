---
description: 绘本插画 / Storybook art via TaoziAPI (kind=storybook)
argument-hint: "prompt…"
---

# /tzai-storybook

Generate **绘本插画** (Storybook art) with TaoziAPI.

**Kind:** `storybook` · **Category:** 影像与插画 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> storybook --prompt "<subject>" --image "./tzai-storybook-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
