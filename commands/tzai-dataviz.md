---
description: 数据可视化 / Data viz art via TaoziAPI (kind=dataviz)
argument-hint: "prompt…"
---

# /tzai-dataviz

Generate **数据可视化** (Data viz art) with TaoziAPI.

**Kind:** `dataviz` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> dataviz --prompt "<subject>" --image "./tzai-dataviz-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
