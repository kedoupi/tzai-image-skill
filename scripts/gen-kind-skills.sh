#!/usr/bin/env bash
# Generate thin slash-command skills + command markdown from kinds.tsv
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
exec python3 - "$ROOT" <<'PY'
import json, shutil
from pathlib import Path
from collections import defaultdict

root = Path(__import__("sys").argv[1])
kinds_path = root / "skills" / "tzai-image" / "references" / "kinds.tsv"
skills_out = root / "skills"
cmd_out = root / "commands"
cmd_out.mkdir(parents=True, exist_ok=True)

# Remove previously generated thin skills (keep engine)
for p in skills_out.iterdir():
    if p.is_dir() and p.name != "tzai-image":
        shutil.rmtree(p)

rows = []
for line in kinds_path.read_text(encoding="utf-8").splitlines():
    if not line.strip() or line.startswith("#"):
        continue
    parts = line.split("\t")
    if len(parts) < 7:
        continue
    rows.append({
        "id": parts[0],
        "category": parts[1],
        "category_zh": parts[2],
        "ar": parts[3],
        "label_en": parts[4],
        "label_zh": parts[5],
        "prefix": parts[6],
    })

by_cat = defaultdict(list)
for r in rows:
    by_cat[r["category"]].append(r)

cat_labels = {
    "brand": "品牌识别",
    "diagram": "结构图示",
    "product": "产品设计",
    "marketing": "市场内容",
    "social": "社交种草",
    "photo": "影像插画",
}

def write_kind_skill(r):
    skill_name = f"tzai-{r['id']}"
    skill_dir = skills_out / skill_name
    skill_dir.mkdir(parents=True, exist_ok=True)
    kid = r["id"]
    body = f'''---
name: {skill_name}
description: >
  Generate {r["label_en"]} ({r["label_zh"]}) images via TaoziAPI using tzai-image kind={kid}.
  Use when the user runs /{skill_name}, /tzai-image {kid}, or asks for {r["label_zh"]} / {r["label_en"]}.
  Category: {r["category"]} ({r["category_zh"]}). Default aspect {r["ar"]}. Requires tzai-image engine + TZAI_API_KEY.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "{r["label_zh"]} · {r["category_zh"]}"
  tzai-kind: "{kid}"
  tzai-category: "{r["category"]}"
---

# {skill_name} — {r["label_zh"]}

Slash: **`/{skill_name}`** · Engine kind: **`{kid}`** · Category: **{r["category_zh"]}** · Default AR: **{r["ar"]}**

Thin slash entry for the `{kid}` scenario. Generation uses the **tzai-image** engine (default `gpt-image-2`).

## Resolve engine

```bash
ENGINE=""
for c in \\
  "$HOME/.agents/skills/tzai-image/scripts/tzai-image" \\
  "$HOME/.claude/skills/tzai-image/scripts/tzai-image" \\
  "$HOME/.codex/skills/tzai-image/scripts/tzai-image" \\
  "$HOME/.grok/skills/tzai-image/scripts/tzai-image" \\
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
bash "$ENGINE" {kid} \\
  --prompt "<user subject>" \\
  --image "./tzai-{kid}-$(date +%Y%m%d-%H%M%S).png"
```

## Kind direction

{r["prefix"]}

## See also

- `bash $ENGINE kinds` · main slash `/tzai-image`
- https://github.com/kedoupi/tzai-image-skill
'''
    (skill_dir / "SKILL.md").write_text(body, encoding="utf-8")

    cmd = f'''---
description: {r["label_zh"]} / {r["label_en"]} via TaoziAPI (kind={kid})
argument-hint: "prompt…"
---

# /{skill_name}

Generate **{r["label_zh"]}** ({r["label_en"]}) with TaoziAPI.

**Kind:** `{kid}` · **Category:** {r["category_zh"]} · **AR:** {r["ar"]}

## Steps

1. Find engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. If missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = subject prompt
5. Run:

```bash
bash <engine> {kid} --prompt "<subject>" --image "./tzai-{kid}-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Model defaults to gpt-image-2.
'''
    (cmd_out / f"{skill_name}.md").write_text(cmd, encoding="utf-8")

def write_cat_skill(cat, items):
    skill_name = f"tzai-{cat}"
    skill_dir = skills_out / skill_name
    skill_dir.mkdir(parents=True, exist_ok=True)
    kinds_list = ", ".join(r["id"] for r in items)
    label = cat_labels.get(cat, cat)
    first = items[0]["id"] if items else "icon"
    body = f'''---
name: {skill_name}
description: >
  Category hub for {label} ({cat}) image generation via TaoziAPI.
  Use when the user runs /{skill_name} or wants any {cat} visual: {kinds_list}.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
argument-hint: "kind prompt…  e.g. {first} <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.2.1"
  short-description: "{label}分类 · {cat}"
  tzai-category: "{cat}"
---

# /{skill_name} — {label}

Kinds: `{"` `".join(r["id"] for r in items)}`

1. If user named a kind above, use it; else infer or ask.
2. Run:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> \\
  --prompt "<subject>" --image "./tzai-<kind>-out.png"
```
'''
    (skill_dir / "SKILL.md").write_text(body, encoding="utf-8")
    cmd = f'''---
description: {label}生图分类 ({cat})
argument-hint: "kind prompt…"
---

# /{skill_name}

**{label}** · kinds: {kinds_list}

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> --prompt "<主题>" --image out.png
```
'''
    (cmd_out / f"{skill_name}.md").write_text(cmd, encoding="utf-8")

for r in rows:
    write_kind_skill(r)
for cat, items in by_cat.items():
    write_cat_skill(cat, items)

# skills.sh.json
labels = {
    "brand": ("Brand / 品牌识别", "Icons, logos, mascots, badges, avatars"),
    "diagram": ("Diagram / 结构图示", "Flowcharts, architecture, mind maps, infographics"),
    "product": ("Product / 产品设计", "UI mocks, wireframes, empty states, onboarding"),
    "marketing": ("Marketing / 市场内容", "Slides, banners, covers, posters, email headers"),
    "social": ("Social / 社交种草", "Xiaohongshu (小红书), WeChat visuals"),
    "photo": ("Photo & illustration / 影像插画", "Product, photo, landscape, storybook, food"),
}
groupings = [{
    "title": "TaoziAPI Image Engine",
    "description": "Core engine + doctor/init/kinds (gpt-image-2)",
    "skills": ["tzai-image"],
}]
for cat, (title, desc) in labels.items():
    skills = [f"tzai-{cat}"] + [f"tzai-{r['id']}" for r in by_cat.get(cat, [])]
    groupings.append({"title": title, "description": desc, "skills": skills})

out = {
    "$schema": "https://skills.sh/schemas/skills.sh.schema.json",
    "groupings": groupings,
}
(root / "skills.sh.json").write_text(json.dumps(out, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

n_skills = len([p for p in skills_out.iterdir() if p.is_dir()])
n_cmds = len(list(cmd_out.glob("*.md")))
print(f"Generated {n_skills} skill dirs, {n_cmds} command files")
PY
