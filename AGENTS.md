# AGENTS.md

Guidance for AI coding agents working in this repository.

This file is the **source of truth**. Optional `CLAUDE.md` only points here.

## Purpose

Installable **tzai-image** Creative Agent family: natural-language project planning plus image generation via TaoziAPI (`https://tzai.kdp.cool`).

```bash
npx skills add kedoupi/tzai-image-skill -g --all
```

## Layout

Product skill contract (docs vs tests vs artifacts):

```text
tzai-image-skill/                 # child repo root (not the install package)
├── skills/
│   ├── tzai-image/               # installable engine package
│   │   ├── SKILL.md
│   │   ├── config.example.env
│   │   ├── scripts/
│   │   │   ├── tzai-image
│   │   │   └── validate-workflow-plan
│   │   └── references/           # kinds, patterns, workflows, presets, schemas
│   └── tzai-*/                   # thin slash skills (generated)
├── commands/                     # client slash wrappers (generated)
├── scripts/                      # repo tooling (not installed as the skill)
│   ├── gen-kind-skills.sh
│   ├── install-slash-commands.sh
│   ├── gen-demos.sh              # → docs/screenshots/
│   └── run-live-compare.sh       # → artifacts/live/
├── docs/                         # human product docs + curated gallery
│   ├── README.md
│   ├── SCENES.md
│   ├── demos.tsv
│   ├── screenshots/              # README gallery only
│   ├── architecture/             # roadmap, workflow, patterns catalog
│   └── research/                 # external methodology notes
├── tests/                        # offline CI + live *specs*
│   ├── README.md
│   ├── run.sh
│   ├── fixtures/
│   └── live/<suite>/             # cases.tsv + rubric (no PNGs)
└── artifacts/                    # generated outputs (not installable)
    ├── README.md
    └── live/<suite>/<version>/   # pairs/ + report.md
```

| Tree | Responsibility |
| --- | --- |
| `skills/` | What `npx skills add` installs |
| `docs/` | Guides, architecture, curated screenshots |
| `tests/` | Offline tests + live case definitions |
| `artifacts/` | Paid/live image outputs and run reports |

## Plan C slash surface

| Layer | Contents |
| --- | --- |
| Engine | `/tzai-image` |
| Hubs (6) | brand, diagram, product, marketing, social, photo |
| High-freq kinds (11) | icon, logo, flowchart, architecture, infographic, cover, slide, xhs, xhs-cover, wechat, ui |
| Long-tail | remaining kinds in `kinds.tsv` → engine only |

Whitelist: `skills/tzai-image/references/slash-whitelist.txt`.  
After editing kinds or whitelist: `bash scripts/gen-kind-skills.sh`.

## Editing rules

- Keep engine `SKILL.md` under ~500 lines; strong description triggers.
- Never hardcode API keys; never commit secrets.
- Support **global env** `TZAI_API_KEY` without requiring `init`.
- Durable config: `~/.agents/skills/.skill-data/tzai-image/config.env` (or skills-parent `.skill-data/`).
- Config files are **KEY=VALUE only** (parser does **not** `source` shell).
- `--dry-run` must stay offline.
- Workflow plan validation must stay offline and enforce plan/anchor approvals before batch work.
- Multi-asset workflows require one approved plan and one approved anchor; never silently batch paid requests.
- Do not copy third-party example images or full prompts into patterns.
- `doctor` must print console URL + export/init examples when key missing.
- Bump `metadata.version` in `skills/tzai-image/SKILL.md` when behavior changes.
- Prefer bash + python3 + curl; no bun required.
- Prefer English README default + `README.zh-CN.md` for user-facing copy.

## CLI essentials

```bash
E=skills/tzai-image/scripts/tzai-image
bash $E doctor
bash $E kinds
bash $E presets xhs|infographic|cover
bash $E generate --dry-run --kind icon --prompt "spark" --image /tmp/t.png
bash $E xhs --style notion --layout dense --prompt "三步写周报" --image out.png
bash $E cover --type hero --palette dark --text none --prompt "主题" --image c.png
```

Matrix flags: `--style` `--layout` `--palette` `--preset` `--type` `--rendering` `--text` `--mood`.  
Reference image: `--ref path.png` (uses edits endpoint; repeatable).

Agent workflows: `skills/tzai-image/references/workflows/index.tsv`.
Visual patterns: `skills/tzai-image/references/patterns/index.tsv`.
Plan validation: `python3 skills/tzai-image/scripts/validate-workflow-plan --catalog-only`.

## Validation

```bash
bash tests/run.sh
# optional one-shot live smoke inside run.sh (costs credits):
TZAI_LIVE=1 bash tests/run.sh

# versioned before/after live suite → artifacts/live/<suite>/<version>/
bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.2

bash scripts/gen-kind-skills.sh   # if whitelist/kinds changed
bash skills/tzai-image/scripts/tzai-image doctor
```

See `docs/README.md`, `tests/README.md`, `artifacts/README.md`.

## Naming note

- Hub `/tzai-product` = **产品设计** (ui / wireframe / …).
- Kind `product-photo` under photo = **商品摄影** (alias `product`) → `/tzai-image product-photo` or hub `/tzai-photo`.
