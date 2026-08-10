---
description: 小红书图卡 / Xiaohongshu / 小红书 card via TaoziAPI (kind=xhs)
argument-hint: "prompt…"
---

# /tzai-xhs

Generate **小红书图卡** (Xiaohongshu / 小红书 card) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `xhs` · **Category:** 社交种草 · **AR:** 3:4

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> xhs --prompt "<subject>" --image "./tzai-xhs-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
