---
description: 邮件头图 / Email header via TaoziAPI (kind=email-header)
argument-hint: "prompt…"
---

# /tzai-email-header

Generate **邮件头图** (Email header) with TaoziAPI.

**Kind:** `email-header` · **Category:** 市场内容 · **AR:** 16:9

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> email-header --prompt "<subject>" --image "./tzai-email-header-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
