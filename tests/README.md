# Tests

## Layers

| Layer | Path | Network | CI default |
| --- | --- | --- | --- |
| **Offline** | `run.sh` + `fixtures/` | No | Yes — always green |
| **Live specs** | `live/<suite>/` | Specs only (text) | Specs versioned; run optional |
| **Live outputs** | `../artifacts/live/` | Yes (paid) | Not required for merge |

## Offline

```bash
bash tests/run.sh
```

- Syntax, doctor, dry-run, kinds, matrices, config safety, workflow validator  
- Fixtures under `fixtures/` (intent routing, sample asset plans)

Optional single live smoke still inside `run.sh`:

```bash
TZAI_LIVE=1 bash tests/run.sh
```

## Live evaluation suites

```text
tests/live/
├── README.md                 # this file (suite index below)
└── pattern-compile/
    ├── cases.tsv             # before/after prompts + flags
    └── rubric.md             # how to score pairs
```

Run a suite (writes under `artifacts/`):

```bash
bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.2
bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.1 --only 07-flowchart
```

Rules:

1. **Specs** (prompts, rubrics) live in `tests/live/` and are committed.  
2. **Pixels / reports** go to `artifacts/live/<suite>/<version>/`.  
3. Do not store large PNGs under `docs/` or `tests/`.  
4. Never auto-retry paid failures; suite runner uses the CLI as-is.
