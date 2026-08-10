#!/usr/bin/env bash
# Generate Plan C slash surface from kinds.tsv + slash-whitelist.txt
# Plan C = engine + 6 category hubs + high-frequency kinds only.
# Long-tail kinds remain callable via engine CLI / natural language, not as thin skills.
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
exec python3 - "$ROOT" <<'PY'
import json, shutil
from pathlib import Path
from collections import defaultdict

root = Path(__import__("sys").argv[1])
kinds_path = root / "skills" / "tzai-image" / "references" / "kinds.tsv"
white_path = root / "skills" / "tzai-image" / "references" / "slash-whitelist.txt"
skills_out = root / "skills"
cmd_out = root / "commands"
cmd_out.mkdir(parents=True, exist_ok=True)

VERSION = "0.5.0"

# Remove previously generated thin skills (keep engine)
for p in skills_out.iterdir():
    if p.is_dir() and p.name != "tzai-image":
        shutil.rmtree(p)
for f in cmd_out.glob("tzai-*.md"):
    f.unlink()

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
by_id = {r["id"]: r for r in rows}
by_cat = defaultdict(list)
for r in rows:
    by_cat[r["category"]].append(r)

# Parse whitelist
white_cats = []
white_kinds = []
for line in white_path.read_text(encoding="utf-8").splitlines():
    line = line.strip()
    if not line or line.startswith("#"):
        continue
    parts = line.split("\t")
    if len(parts) < 2:
        parts = line.split()
    if len(parts) < 2:
        continue
    typ, ident = parts[0].strip(), parts[1].strip()
    if typ == "category":
        white_cats.append(ident)
    elif typ == "kind":
        white_kinds.append(ident)

cat_labels = {
    "brand": ("品牌识别", "Brand identity", "Icons, logos, mascots, badges, avatars, mood boards"),
    "diagram": ("结构图示", "Diagrams & structure", "Flowcharts, architecture, mind maps, infographics"),
    "product": ("产品设计", "Product design", "UI mocks, wireframes, empty states, onboarding"),
    "marketing": ("市场内容", "Marketing", "Slides, banners, covers, posters, email headers"),
    "social": ("社交种草", "Social content", "Xiaohongshu (小红书), WeChat visuals"),
    "photo": ("影像插画", "Photo & illustration", "Product, photo, landscape, storybook, food"),
}

def engine_resolve_block():
    return '''## Resolve engine

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
  echo "Install engine: npx skills add kedoupi/tzai-image-skill -g --skill tzai-image -y" >&2
  exit 1
fi
```'''

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
  High-frequency Plan C slash entry.
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "{VERSION}"
  short-description: "{r["label_zh"]} · {r["category_zh"]}"
  tzai-kind: "{kid}"
  tzai-category: "{r["category"]}"
  tzai-slash: "plan-c"
---

# {skill_name} — {r["label_zh"]}

Slash: **`/{skill_name}`** · Engine kind: **`{kid}`** · Category: **{r["category_zh"]}** · Default AR: **{r["ar"]}**

High-frequency scene entry (Plan C). Generation uses the **tzai-image** engine (default `gpt-image-2`).

{engine_resolve_block()}

## Run

Slash arguments / remaining user text = **subject only** (art direction is injected by kind).

```bash
bash "$ENGINE" {kid} \\
  --prompt "<user subject>" \\
  --image "./tzai-{kid}-$(date +%Y%m%d-%H%M%S).png"
```
'''
    # P0 matrix hints for selected kinds
    if kid in ("xhs", "xhs-cover"):
        body += f'''
### P0 matrix (style × layout)

```bash
bash "$ENGINE" presets xhs
bash "$ENGINE" {kid} --style notion --layout dense --prompt "<subject>" --image out.png
bash "$ENGINE" {kid} --preset knowledge-card --prompt "<subject>" --image out.png
```

Series workflow: engine `references/workflows/xhs-series.md`.
'''
    elif kid == "infographic":
        body += '''
### P0 matrix (layout × style)

```bash
bash "$ENGINE" presets infographic
bash "$ENGINE" infographic --layout funnel --style tech-schematic --prompt "<subject>" --image out.png
```
'''
    elif kid == "cover":
        body += '''
### P0 dimensions (type × palette × rendering × text × mood)

```bash
bash "$ENGINE" presets cover
bash "$ENGINE" cover --type hero --palette dark --mood bold --text none --prompt "<subject>" --image out.png
```
'''
    body += f'''
## Kind direction

{r["prefix"]}

## Teaching tip

- Put **what to draw** in the prompt, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-{r["category"]}` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-{r["category"]}`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
'''
    (skill_dir / "SKILL.md").write_text(body, encoding="utf-8")

    cmd = f'''---
description: {r["label_zh"]} / {r["label_en"]} via TaoziAPI (kind={kid})
argument-hint: "prompt…"
---

# /{skill_name}

Generate **{r["label_zh"]}** ({r["label_en"]}) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `{kid}` · **Category:** {r["category_zh"]} · **AR:** {r["ar"]}

## Steps

1. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
2. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
3. Ensure `TZAI_API_KEY` or `tzai-image init`
4. Slash args = **subject only**
5. Run:

```bash
bash <engine> {kid} --prompt "<subject>" --image "./tzai-{kid}-$(date +%Y%m%d-%H%M%S).png"
```

6. Report output path. Default model: **gpt-image-2**.
'''
    (cmd_out / f"{skill_name}.md").write_text(cmd, encoding="utf-8")

def write_cat_skill(cat, items):
    skill_name = f"tzai-{cat}"
    skill_dir = skills_out / skill_name
    skill_dir.mkdir(parents=True, exist_ok=True)
    zh, en, desc = cat_labels.get(cat, (cat, cat, cat))
    kinds_ids = [r["id"] for r in items]
    kinds_list = ", ".join(kinds_ids)
    # which kinds have direct slashes
    direct = [k for k in kinds_ids if k in white_kinds]
    long_tail = [k for k in kinds_ids if k not in white_kinds]
    first = direct[0] if direct else (kinds_ids[0] if kinds_ids else "icon")
    table_lines = []
    for r in items:
        slash = f"/tzai-{r['id']}" if r["id"] in white_kinds else f"/tzai-image {r['id']}"
        table_lines.append(f"| `{r['id']}` | {r['label_zh']} | {r['ar']} | `{slash}` |")
    table = "\n".join(table_lines)
    direct_s = ", ".join(f"`/tzai-{k}`" for k in direct) or "(none)"
    long_s = ", ".join(f"`{k}`" for k in long_tail) or "(none)"

    body = f'''---
name: {skill_name}
description: >
  Category hub for {zh} ({cat}) image generation via TaoziAPI.
  Use when the user runs /{skill_name} or wants any {cat} visual: {kinds_list}.
  Pick a concrete kind then call the tzai-image engine. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. {first} <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "{VERSION}"
  short-description: "{zh}分类 · {cat}"
  tzai-category: "{cat}"
  tzai-slash: "plan-c-hub"
---

# /{skill_name} — {zh} ({en})

**Category hub** (Plan C). Do **not** invent a new kind — pick one below, then generate.

{desc}.

{engine_resolve_block()}

## Kinds in this category

| Kind | 中文 | AR | How to invoke |
| --- | --- | --- | --- |
{table}

- **Direct slash (high-freq):** {direct_s}
- **Long-tail (via hub / engine):** {long_s}

## Agent flow

1. If user already named a kind in the table → use it.
2. Else infer from intent (e.g. 图标→`icon`, 流程图→`flowchart`) or ask once.
3. Subject only in `--prompt`:

```bash
bash "$ENGINE" <kind> \\
  --prompt "<subject>" \\
  --image "./tzai-<kind>-$(date +%Y%m%d-%H%M%S).png"
```

## Teaching tip

Use this hub when the user says a **broad** need (“做点品牌图”“来张结构图”).  
If they already know the scene (“小红书图卡”“架构图”), prefer the **direct slash** for fewer turns.

## See also

- Engine `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
'''
    (skill_dir / "SKILL.md").write_text(body, encoding="utf-8")

    cmd = f'''---
description: {zh}生图分类 hub ({cat}) · Plan C
argument-hint: "kind prompt…"
---

# /{skill_name}

**{zh}** category hub. Kinds: {kinds_list}

1. Pick kind → 2. subject prompt → 3. generate:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> --prompt "<主题>" --image out.png
```

High-freq direct slashes: {direct_s}
'''
    (cmd_out / f"{skill_name}.md").write_text(cmd, encoding="utf-8")

# Validate whitelist
for c in white_cats:
    if c not in by_cat:
        raise SystemExit(f"Unknown category in whitelist: {c}")
for k in white_kinds:
    if k not in by_id:
        raise SystemExit(f"Unknown kind in whitelist: {k}")

for kid in white_kinds:
    write_kind_skill(by_id[kid])
for cat in white_cats:
    write_cat_skill(cat, by_cat[cat])

# skills.sh.json — Plan C groupings only
groupings = [{
    "title": "TaoziAPI Image Engine",
    "description": "Core engine + doctor/init/kinds (gpt-image-2). Long-tail kinds via this skill.",
    "skills": ["tzai-image"],
}]
for cat in white_cats:
    zh, en, desc = cat_labels[cat]
    skills = [f"tzai-{cat}"] + [
        f"tzai-{r['id']}" for r in by_cat[cat] if r["id"] in white_kinds
    ]
    # de-dupe while preserving order (hub product-design ≠ kind product-photo)
    seen = set()
    uniq = []
    for s in skills:
        if s not in seen:
            seen.add(s)
            uniq.append(s)
    groupings.append({
        "title": f"{en} / {zh}",
        "description": desc + " (Plan C: hub + high-freq slashes)",
        "skills": uniq,
    })

out = {
    "$schema": "https://skills.sh/schemas/skills.sh.schema.json",
    "groupings": groupings,
}
(root / "skills.sh.json").write_text(json.dumps(out, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

n_skills = len([p for p in skills_out.iterdir() if p.is_dir()])
n_cmds = len(list(cmd_out.glob("*.md")))
print(f"Plan C: {n_skills} skill dirs (engine+hubs+kinds), {n_cmds} command files")
print(f"  categories: {', '.join(white_cats)}")
print(f"  kinds:      {', '.join(white_kinds)}")
print(f"  long-tail:  {len(rows) - len(white_kinds)} kinds via engine only")
PY
