---
description: 微信配图 / WeChat article visual via TaoziAPI (kind=wechat)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-wechat

Generate **微信配图** (WeChat article visual) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `wechat` · **Category:** 社交种草 · **AR:** 16:9

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> wechat --prompt "<subject>" --image "./tzai-wechat-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
