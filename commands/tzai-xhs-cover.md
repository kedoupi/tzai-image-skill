---
description: 小红书封面 / XHS cover via TaoziAPI (kind=xhs-cover)
argument-hint: "prompt…"
---

# /tzai-xhs-cover

Generate **小红书封面** (XHS cover) with TaoziAPI.

**Kind:** `xhs-cover` · **Category:** 社交种草 · **AR:** 3:4

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> xhs-cover --prompt "<subject>" --image "./tzai-xhs-cover-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
