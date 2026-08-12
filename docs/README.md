# Documentation

Human-facing product docs for **tzai-image-skill**.  
Installable package code lives under `skills/` only; this tree is repo-local.

## Layout

```text
docs/
├── README.md                 # this index
├── SCENES.md                 # kind / scene catalog for users
├── demos.tsv                 # gallery generation index → docs/screenshots/
├── screenshots/              # curated README gallery (published assets)
├── architecture/             # product design SoT
│   ├── CAPABILITY-ROADMAP.md
│   ├── CREATIVE-WORKFLOW-ARCHITECTURE.md
│   ├── PATTERN-LIBRARY.md
│   └── WORKFLOW-CATALOG.md
└── research/                 # external research notes (methodology only)
    ├── awesome-gpt-image-2.md
    └── awesome-gpt-image-2-gap.md
```

## What belongs where

| Path | Put here | Do **not** put here |
| --- | --- | --- |
| `docs/*.md` + `architecture/` | Design, catalogs, user guides | Binary dumps, ephemeral A/B runs |
| `docs/screenshots/` | Curated gallery for README | Raw benchmark pairs |
| `docs/research/` | Source notes + gap matrices | Full third-party prompts/images |
| `tests/` | Offline CI + live **specs** | Generated PNGs |
| `artifacts/` | Generated images / live reports | Skill source of truth |

## Related trees

| Tree | Role |
| --- | --- |
| [`tests/`](../tests/) | Offline `run.sh` + fixtures + live case definitions |
| [`artifacts/`](../artifacts/) | Paid/live generation outputs |
| [`skills/tzai-image/`](../skills/tzai-image/) | Installable engine package |
