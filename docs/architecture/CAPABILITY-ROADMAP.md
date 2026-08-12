# tzai-image Capability Roadmap

> Product: natural-language Creative Agent plus the TaoziAPI image engine.
> Principle: users describe outcomes; workflows, patterns, kinds, matrices, and CLI calls stay internal.

## Architecture

```text
user outcome
  -> workflow router
  -> reusable interaction modules
  -> visual patterns
  -> existing kinds / matrices / --ref
  -> one paid engine call per asset
```

The public Plan C surface remains one engine, six category hubs, and eleven high-frequency direct kinds. It is an expert shortcut, not the primary discovery experience.

## v0.6 Delivered

| Capability | Status |
| --- | --- |
| Natural-language single vs project routing | Done |
| 27 outcome workflows | Done: 10 stable, 13 guided, 4 expert-review |
| 22 independently written visual patterns | Done |
| Shared intake, planning, approval, consistency, rights, facts, and delivery modules | Done |
| Two-stage plan and anchor approval | Done |
| Creative brief, asset plan, and deliverables schemas | Done |
| Offline catalog and plan validator | Done |
| XHS note, WeChat article, article illustration, UI flow, deck package | Stable |
| Brand starter, product launch, campaign kit, knowledge visual, character IP | Stable |
| Existing `--ref` edits and opt-in live smoke | Done since v0.5.3 |
| Single-attempt paid calls and atomic output safety | Done since v0.5.4 |

## v0.6.1 Delivered

| Capability | Status |
| --- | --- |
| Gap matrix vs awesome-gpt-image-2 methodology | Done (`docs/research/awesome-gpt-image-2-gap.md`) |
| Six patterns productionized (slots + compile + negatives) | Done |
| Single-image compile guide + SKILL routing | Done |
| Chinese social text lock on social kinds | Done |
| Before/after live compare samples | `artifacts/live/pattern-compile/v0.6.1/` · specs `tests/live/pattern-compile/` |

## Next Validation Work

| Priority | Work |
| --- | --- |
| P1 | Expand owned benchmark briefs; score composition, text, consistency |
| P1 | Render-brief schema + optional compile script (Phase 2) |
| P1 | Poster/UI matrices only where prose still fails |
| P1 | Add resumable execution only if agent-managed manifests prove inadequate |
| P2 | Promote guided workflows after repeated real use and review |
| P2 | Add engine-only kinds only when existing primitives cannot represent the result |

## Explicit Boundaries

- No automatic social publishing, scheduling, image compression, scraping, or multi-provider routing.
- No claim of editable Figma, PSD, SVG, CAD, or construction output.
- Long copy, verified facts, prices, legal claims, and precise data remain external text artifacts.
- Professional, cultural, medical, architectural, trademark, and deceptive-mockup risks require the review documented by the workflow.
- External example libraries inform generalized methods only; no third-party images or complete prompts are copied into this package.

## Acceptance

```bash
python3 skills/tzai-image/scripts/validate-workflow-plan --catalog-only
bash scripts/gen-kind-skills.sh
bash tests/run.sh
npx skills add ./ --list
```

Paid compatibility remains optional and explicit:

```bash
TZAI_LIVE=1 bash tests/run.sh
```

## History

| Version | Summary |
| --- | --- |
| v0.5 | Plan C, kinds, matrices, reference edits, multi-image playbooks |
| v0.5.4 | Paid-call, config, response, output, generator, and installer hardening |
| v0.6.0 | Agent-led workflow/pattern architecture, two-stage approvals, schemas, and offline validation |
| v0.6.1 | Production pattern compile for six high-freq methods + CN social text lock + gap matrix |
