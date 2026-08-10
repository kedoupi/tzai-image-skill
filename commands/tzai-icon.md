---
description: App图标 / App icon via TaoziAPI (kind=icon)
argument-hint: "prompt…"
tzai-generated-by: tzai-image-skill
---

# /tzai-icon

Generate **App图标** (App icon) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `icon` · **Category:** 品牌识别 · **AR:** 1:1

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> icon --prompt "<subject>" --image "./tzai-icon-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
