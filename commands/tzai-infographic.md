---
description: 信息图 / Infographic via TaoziAPI (kind=infographic)
argument-hint: "prompt…"
---

# /tzai-infographic

Generate **信息图** (Infographic) with TaoziAPI.

**Kind:** `infographic` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> infographic --prompt "<subject>" --image "./tzai-infographic-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
