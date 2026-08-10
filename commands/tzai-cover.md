---
description: 文章封面 / Article cover via TaoziAPI (kind=cover)
argument-hint: "prompt…"
---

# /tzai-cover

Generate **文章封面** (Article cover) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `cover` · **Category:** 市场内容 · **AR:** 16:9

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> cover --prompt "<subject>" --image "./tzai-cover-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
