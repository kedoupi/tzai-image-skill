---
name: tzai-email-header
description: >
  Generate Email header (邮件头图) images via TaoziAPI using tzai-image kind=email-header.
  Use when the user runs /tzai-email-header, /tzai-image email-header, or asks for 邮件头图 / Email header.
  Category: marketing (市场内容). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "邮件头图 · 市场内容"
  tzai-kind: "email-header"
  tzai-category: "marketing"
---

# tzai-email-header — 邮件头图

Slash: **`/tzai-email-header`** · Engine kind: **`email-header`** · Category: **市场内容** · Default AR: **16:9**

Thin slash entry for the `email-header` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

## Resolve engine

```bash
ENGINE=""
for c in \
  "$HOME/.agents/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.claude/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.codex/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.grok/skills/tzai-image/scripts/tzai-image" \
  "$HOME/.cursor/skills/tzai-image/scripts/tzai-image"
do
  if [ -x "$c" ]; then ENGINE="$c"; break; fi
done
if [ -z "$ENGINE" ]; then
  echo "Install engine: npx skills add kedoupi/tzai-image-skill -g --all" >&2
  exit 1
fi
```

## Run

Slash arguments / remaining user text = **subject only**.

```bash
bash "$ENGINE" email-header \
  --prompt "<user subject>" \
  --image "./tzai-email-header-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Email newsletter header graphic, wide hero, modern tech or lifestyle brand feel, no dense text.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
