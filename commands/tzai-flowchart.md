---
description: 流程图 / Flowchart / process via TaoziAPI (kind=flowchart)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-flowchart

Generate **流程图** (Flowchart / process) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `flowchart` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. If the request is a coordinated project, route through the engine workflow catalog instead of this single-asset wrapper.
2. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
3. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
4. Ensure `TZAI_API_KEY` or `tzai-image init`
5. For a single asset, slash args = **subject only**
6. Run:

```bash
bash <engine> flowchart --prompt "<subject>" --image "./tzai-flowchart-$(date +%Y%m%d-%H%M%S).png"
```

7. Report output path. Default model: **gpt-image-2**.
