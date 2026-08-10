---
description: 徽章贴纸 / Badge / sticker set via TaoziAPI (kind=badge)
argument-hint: "prompt…"
---

# /tzai-badge

Generate **徽章贴纸** (Badge / sticker set) with TaoziAPI.

**Kind:** `badge` · **Category:** 品牌识别 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> badge --prompt "<subject>" --image "./tzai-badge-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
