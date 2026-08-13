---
description: 信息图 / Infographic via TaoziAPI (kind=infographic)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-infographic

Generate **信息图** (Infographic) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `infographic` · **Category:** 结构图示 · **AR:** 16:9

## Steps

1. If the request is a coordinated project, route through the engine workflow catalog instead of this single-asset wrapper.
2. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
3. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
4. Ensure `TZAI_API_KEY` or `tzai-image init`
5. For a single asset, compile slots via engine `references/patterns/compile-guide.md` (not a one-line subject unless the user asked for raw)
6. Run:

```bash
bash <engine> infographic --prompt "<compiled visual brief>" --image "./tzai-infographic-$(date +%Y%m%d-%H%M%S).png"
```

7. Report output path. Default model: **gpt-image-2**.
