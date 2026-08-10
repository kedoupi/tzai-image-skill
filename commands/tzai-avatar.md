---
description: 职业头像 / Professional avatar via TaoziAPI (kind=avatar)
argument-hint: "prompt…"
---

# /tzai-avatar

Generate **职业头像** (Professional avatar) with TaoziAPI.

**Kind:** `avatar` · **Category:** 品牌识别 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> avatar --prompt "<subject>" --image "./tzai-avatar-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
