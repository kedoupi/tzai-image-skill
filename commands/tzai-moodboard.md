---
description: 品牌情绪板 / Brand mood board via TaoziAPI (kind=moodboard)
argument-hint: "prompt…"
---

# /tzai-moodboard

Generate **品牌情绪板** (Brand mood board) with TaoziAPI.

**Kind:** `moodboard` · **Category:** 品牌识别 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> moodboard --prompt "<subject>" --image "./tzai-moodboard-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
