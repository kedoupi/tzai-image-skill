---
description: 空状态插画 / Empty state via TaoziAPI (kind=empty-state)
argument-hint: "prompt…"
---

# /tzai-empty-state

Generate **空状态插画** (Empty state) with TaoziAPI.

**Kind:** `empty-state` · **Category:** 产品设计 · **AR:** 1:1

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> empty-state --prompt "<subject>" --image "./tzai-empty-state-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
