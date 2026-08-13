#!/usr/bin/env bash
# Generate Plan C slash surface from kinds.tsv + slash-whitelist.txt
# Plan C = engine + 6 category hubs + high-frequency kinds only.
# Long-tail kinds remain callable via engine CLI / natural language, not as thin skills.
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
exec python3 - "$ROOT" <<'PY'
import json
import re
import sys
from pathlib import Path
from collections import defaultdict

root = Path(sys.argv[1])
kinds_path = root / "skills" / "tzai-image" / "references" / "kinds.tsv"
white_path = root / "skills" / "tzai-image" / "references" / "slash-whitelist.txt"
engine_skill_path = root / "skills" / "tzai-image" / "SKILL.md"
skills_out = root / "skills"
cmd_out = root / "commands"
OWNERSHIP_MARKER = "tzai-generated-by: tzai-image-skill"
SEMVER_RE = re.compile(
    r"^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)"
    r"(?:-(?:0|[1-9]\d*|\d*[A-Za-z-][0-9A-Za-z-]*)(?:\.(?:0|[1-9]\d*|\d*[A-Za-z-][0-9A-Za-z-]*))*)?"
    r"(?:\+[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?$"
)

def read_engine_version():
    """Read the authoritative engine version without depending on a YAML parser."""
    try:
        text = engine_skill_path.read_text(encoding="utf-8")
    except OSError as exc:
        raise SystemExit(f"Cannot read engine SKILL.md: {exc}")
    match = re.search(r"(?m)^  version:\s*[\"']?([^\"'\s]+)[\"']?\s*$", text)
    if not match:
        raise SystemExit("Missing metadata.version in skills/tzai-image/SKILL.md")
    version = match.group(1)
    if not SEMVER_RE.fullmatch(version):
        raise SystemExit(f"Invalid metadata.version (expected SemVer): {version}")
    return version

VERSION = read_engine_version()

def is_owned(path):
    try:
        return OWNERSHIP_MARKER in path.read_text(encoding="utf-8")
    except OSError:
        return False

def assert_safe_output(path, output_root):
    """Refuse output paths that escape the repository through symlinks."""
    try:
        path.relative_to(output_root)
    except ValueError:
        raise SystemExit(f"Generated output escapes {output_root}: {path}")
    current = path
    while current != output_root:
        if current.is_symlink():
            raise SystemExit(f"Refuse generated output through symlink: {current}")
        current = current.parent
    if output_root.is_symlink():
        raise SystemExit(f"Refuse symlink output root: {output_root}")

rows = []
for line_no, line in enumerate(kinds_path.read_text(encoding="utf-8").splitlines(), start=1):
    if not line.strip() or line.startswith("#"):
        continue
    parts = line.split("\t")
    if len(parts) < 7:
        raise SystemExit(f"Invalid kinds.tsv row {line_no}: expected at least 7 tab-separated fields")
    if any(not value.strip() for value in parts[:7]):
        raise SystemExit(f"Invalid kinds.tsv row {line_no}: required fields may not be empty")
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
if len(by_id) != len(rows):
    raise SystemExit("Duplicate kind id in kinds.tsv")
by_cat = defaultdict(list)
for r in rows:
    by_cat[r["category"]].append(r)

# Parse whitelist
white_cats = []
white_kinds = []
for line_no, line in enumerate(white_path.read_text(encoding="utf-8").splitlines(), start=1):
    line = line.strip()
    if not line or line.startswith("#"):
        continue
    parts = line.split("\t")
    if len(parts) < 2:
        parts = line.split()
    if len(parts) < 2:
        raise SystemExit(f"Invalid slash-whitelist.txt row {line_no}: expected type and identifier")
    typ, ident = parts[0].strip(), parts[1].strip()
    if typ == "category":
        white_cats.append(ident)
    elif typ == "kind":
        white_kinds.append(ident)
    else:
        raise SystemExit(f"Invalid whitelist entry type on row {line_no}: {typ}")

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

skill_outputs = {}
command_outputs = {}

def write_kind_skill(r):
    skill_name = f"tzai-{r['id']}"
    kid = r["id"]
    extra_desc = ""
    if kid == "wechat":
        extra_desc = (
            "  Not for writing 公众号正文, 推文, or WeChat drafts (use wechat-mp). "
            "This skill generates header/illustration pixels only.\n"
        )
    body = f'''---
name: {skill_name}
description: >
  Generate {r["label_en"]} ({r["label_zh"]}) images via TaoziAPI using tzai-image kind={kid}.
  Use when the user runs /{skill_name}, /tzai-image {kid}, or asks for {r["label_zh"]} / {r["label_en"]}.
  Category: {r["category"]} ({r["category_zh"]}). Default aspect {r["ar"]}. Requires tzai-image engine + TZAI_API_KEY.
  High-frequency Plan C slash entry.
{extra_desc}
argument-hint: "prompt…  e.g. 你的主题内容"
user-invocable: true
metadata:
  author: kedoupi
  version: "{VERSION}"
  {OWNERSHIP_MARKER}
  short-description: "{r["label_zh"]} · {r["category_zh"]}"
  tzai-kind: "{kid}"
  tzai-category: "{r["category"]}"
  tzai-slash: "plan-c"
---

# {skill_name} — {r["label_zh"]}

Slash: **`/{skill_name}`** · Engine kind: **`{kid}`** · Category: **{r["category_zh"]}** · Default AR: **{r["ar"]}**

High-frequency scene entry (Plan C). Generation uses the **tzai-image** engine (default `gpt-image-2`).

{engine_resolve_block()}

## Route before running

Determine the requested outcome before selecting a command:

- One independently useful image → continue with this kind.
- A complete note/article, multi-screen flow, deck, campaign, brand system, or coordinated series → do not collapse it into one image. Read the engine's `references/workflows/index.tsv` and follow the matching project guide, including plan approval and one-anchor approval.

The user does not need to know the kind, pattern, matrix, or CLI.

## Run a single asset

Read the engine `references/patterns/compile-guide.md` and the matched pattern from `references/patterns/index.tsv`. Compile required slots into `--prompt` (task → structure → visual system → short labels → constraints). Kind injects baseline art direction; do not send a one-line vague subject unless the user asked for raw/free-form.

```bash
bash "$ENGINE" {kid} \\
  --prompt "<compiled visual brief>" \\
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

Series workflow: engine `references/workflows/xhs-note.md`.
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

- Compile slots via `compile-guide.md`; put **what to draw** in the brief, not style essays — kind already sets professional direction.
- Override aspect only when needed: `--ar 1:1|16:9|9:16|3:4`.
- Long-tail scenes in the same category: open `/tzai-{r["category"]}` or `/tzai-image <kind>`.

## See also

- Category hub: `/tzai-{r["category"]}`
- Engine: `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
'''
    skill_outputs[skill_name] = body

    cmd = f'''---
description: {r["label_zh"]} / {r["label_en"]} via TaoziAPI (kind={kid})
argument-hint: "prompt…"
{OWNERSHIP_MARKER}
---

# /{skill_name}

Generate **{r["label_zh"]}** ({r["label_en"]}) with TaoziAPI · Plan C high-frequency slash.

**Kind:** `{kid}` · **Category:** {r["category_zh"]} · **AR:** {r["ar"]}

## Steps

1. If the request is a coordinated project, route through the engine workflow catalog instead of this single-asset wrapper.
2. Engine: `~/.agents/skills/tzai-image/scripts/tzai-image` (or ~/.claude|codex|grok/skills/...)
3. Install if missing: `npx skills add kedoupi/tzai-image-skill -g --all`
4. Ensure `TZAI_API_KEY` or `tzai-image init`
5. For a single asset, compile slots via engine `references/patterns/compile-guide.md` (not a one-line subject unless the user asked for raw)
6. Run:

```bash
bash <engine> {kid} --prompt "<compiled visual brief>" --image "./tzai-{kid}-$(date +%Y%m%d-%H%M%S).png"
```

7. Report output path. Default model: **gpt-image-2**.
'''
    command_outputs[skill_name] = cmd

def write_cat_skill(cat, items):
    skill_name = f"tzai-{cat}"
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
  Infer a single kind or route a coordinated project through the engine workflow catalog. Requires TZAI_API_KEY.
  Plan C: hub routes; high-frequency kinds also have direct slashes.
argument-hint: "kind prompt…  e.g. {first} <主题>"
user-invocable: true
metadata:
  author: kedoupi
  version: "{VERSION}"
  {OWNERSHIP_MARKER}
  short-description: "{zh}分类 · {cat}"
  tzai-category: "{cat}"
  tzai-slash: "plan-c-hub"
---

# /{skill_name} — {zh} ({en})

**Category hub** (Plan C). Infer the user's outcome; do not make the user learn this taxonomy.

{desc}.

{engine_resolve_block()}

## Kinds in this category

| Kind | 中文 | AR | How to invoke |
| --- | --- | --- | --- |
{table}

- **Direct slash (high-freq):** {direct_s}
- **Long-tail (via hub / engine):** {long_s}

## Agent flow

1. Distinguish one asset from a coordinated project.
2. For a project, read the engine's `references/workflows/index.tsv`, select the matching guide, and follow both approval gates.
3. For one asset, infer the kind from intent; ask once only if ambiguity materially changes the result.
4. Compile slots into `--prompt` using the engine `references/patterns/compile-guide.md` (not a one-line subject unless the user asked for raw):

```bash
bash "$ENGINE" <kind> \\
  --prompt "<compiled visual brief>" \\
  --image "./tzai-<kind>-$(date +%Y%m%d-%H%M%S).png"
```

## Teaching tip

Use this hub when the user expresses a broad outcome. Kinds and direct slashes are internal shortcuts; present a recommendation, not a command menu.

## See also

- Engine `/tzai-image` · `bash $ENGINE kinds`
- Demos: https://github.com/kedoupi/tzai-image-skill#gallery
'''
    skill_outputs[skill_name] = body

    cmd = f'''---
description: {zh}生图分类 hub ({cat}) · Plan C
argument-hint: "kind prompt…"
{OWNERSHIP_MARKER}
---

# /{skill_name}

**{zh}** category hub. Kinds: {kinds_list}

1. Infer outcome → 2. route project or single kind → 3. generate after the required approval:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image <kind> --prompt "<主题>" --image out.png
```

High-freq direct slashes: {direct_s}
'''
    command_outputs[skill_name] = cmd

# Validate whitelist
for c in white_cats:
    if c not in by_cat:
        raise SystemExit(f"Unknown category in whitelist: {c}")
    if c not in cat_labels:
        raise SystemExit(f"Missing category labels for whitelist category: {c}")
for k in white_kinds:
    if k not in by_id:
        raise SystemExit(f"Unknown kind in whitelist: {k}")
if len(set(white_cats)) != len(white_cats):
    raise SystemExit("Duplicate category in whitelist")
if len(set(white_kinds)) != len(white_kinds):
    raise SystemExit("Duplicate kind in whitelist")
target_names = [f"tzai-{k}" for k in white_kinds] + [f"tzai-{c}" for c in white_cats]
if len(set(target_names)) != len(target_names):
    raise SystemExit("Whitelist produces duplicate generated paths")

for kid in white_kinds:
    write_kind_skill(by_id[kid])
for cat in white_cats:
    write_cat_skill(cat, by_cat[cat])

# All inputs and generated content have been validated before touching outputs.
# Only expected paths are overwritten; stale artifacts require our marker.
for skill_name in skill_outputs:
    assert_safe_output(skills_out / skill_name / "SKILL.md", skills_out)
for skill_name in command_outputs:
    assert_safe_output(cmd_out / f"{skill_name}.md", cmd_out)
skills_out.mkdir(parents=True, exist_ok=True)
cmd_out.mkdir(parents=True, exist_ok=True)
for skill_name, body in skill_outputs.items():
    skill_path = skills_out / skill_name / "SKILL.md"
    skill_path.parent.mkdir(parents=True, exist_ok=True)
    skill_path.write_text(body, encoding="utf-8")
for skill_name, body in command_outputs.items():
    (cmd_out / f"{skill_name}.md").write_text(body, encoding="utf-8")

for skill_dir in skills_out.iterdir():
    if skill_dir.is_symlink() or not skill_dir.is_dir() or skill_dir.name == "tzai-image":
        continue
    skill_path = skill_dir / "SKILL.md"
    if skill_dir.name not in skill_outputs and skill_path.is_file() and is_owned(skill_path):
        skill_path.unlink()
        try:
            skill_dir.rmdir()
        except OSError:
            pass  # User files in a formerly generated directory are preserved.
for command_path in cmd_out.glob("tzai-*.md"):
    if command_path.stem not in command_outputs and command_path.is_file() and is_owned(command_path):
        command_path.unlink()

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
