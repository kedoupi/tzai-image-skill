---
description: 微信配图 / WeChat article visual via TaoziAPI (kind=wechat)
argument-hint: "prompt…"
---

# /tzai-wechat

Generate **微信配图** (WeChat article visual) with TaoziAPI.

**Kind:** `wechat` · **Category:** 社交种草 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> wechat --prompt "<subject>" --image "./tzai-wechat-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
