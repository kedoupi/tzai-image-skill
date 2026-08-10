---
description: 思维导图 / Mind map via TaoziAPI (kind=mindmap)
argument-hint: "prompt…"
---

# /tzai-mindmap

Generate **思维导图** (Mind map) with TaoziAPI.

**Kind:** `mindmap` · **Category:** 结构图示 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> mindmap --prompt "<subject>" --image "./tzai-mindmap-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
