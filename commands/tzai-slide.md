---
description: PPT封面 / Slide / deck cover via TaoziAPI (kind=slide)
argument-hint: "prompt…"
---

# /tzai-slide

Generate **PPT封面** (Slide / deck cover) with TaoziAPI.

**Kind:** `slide` · **Category:** 市场内容 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> slide --prompt "<subject>" --image "./tzai-slide-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
