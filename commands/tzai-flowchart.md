---
description: 流程图 / Flowchart / process via TaoziAPI (kind=flowchart)
argument-hint: "prompt…"
---

# /tzai-flowchart

Generate **流程图** (Flowchart / process) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `flowchart` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> flowchart --prompt "<subject>" --image "./tzai-flowchart-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
