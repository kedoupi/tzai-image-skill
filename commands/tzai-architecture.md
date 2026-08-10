---
description: 架构图 / System architecture via TaoziAPI (kind=architecture)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-architecture

Generate **架构图** (System architecture) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `architecture` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> architecture --prompt "<subject>" --image "./tzai-architecture-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
