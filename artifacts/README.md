# Artifacts

**Generated outputs** for this skill repo. Not part of the installable package (`skills/`).

## Layout

```text
artifacts/
├── README.md
└── live/
    └── <suite>/
        └── <version>/
            ├── report.md
            └── pairs/
                └── <case-id>/
                    ├── before.png
                    └── after.png
```

Example (committed sample run):

```text
artifacts/live/pattern-compile/v0.6.1/
├── report.md
└── pairs/01-ui/{before,after}.png
```

## Conventions

| Rule | Why |
| --- | --- |
| Suite name = `tests/live/<suite>/` | Specs and outputs share an ID |
| Version = skill or experiment tag (`v0.6.1`, `exp-cn-lock`) | Compare over time |
| One case folder per pair | Easy open / review |
| `report.md` required per run | Scores without hunting chat history |
| Scratch under `artifacts/live/_scratch/` | Local only; gitignored |

## Commands

```bash
# regenerate a versioned live compare
bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.2

# open last sample
open artifacts/live/pattern-compile/v0.6.1/pairs/07-flowchart
```

## Git policy

- Curated evaluation runs **may** be committed (reviewability).  
- Local experiments: use `--version _scratch/$(date +%Y%m%d-%H%M)` or `_scratch/` (ignored).  
- Do not commit API keys or full third-party prompt corpora.
