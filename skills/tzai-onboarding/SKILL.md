---
name: tzai-onboarding
description: >
  Generate Onboarding hero (引导主视觉) images via TaoziAPI using tzai-image kind=onboarding.
  Use when the user runs /tzai-onboarding, /tzai-image onboarding, or asks for 引导主视觉 / Onboarding hero.
  Category: product (产品设计). Default aspect 16:9. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "引导主视觉 · 产品设计"
  tzai-kind: "onboarding"
  tzai-category: "product"
---

# tzai-onboarding — 引导主视觉

Slash: **`/tzai-onboarding`** · Engine kind: **`onboarding`** · Category: **产品设计** · Default AR: **16:9**

Thin slash entry for the `onboarding` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

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
bash "$ENGINE" onboarding \
  --prompt "<user subject>" \
  --image "./tzai-onboarding-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

Product onboarding hero illustration, people or abstract UI metaphors, modern SaaS, bright professional, room for headline, no real logos.

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
