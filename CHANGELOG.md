# Changelog

All notable changes to **tzai-image-skill** are documented here.

## [0.6.0] — 2026-08-11

### Added
- Natural-language Creative Agent routing for single assets and coordinated projects.
- 27 outcome workflows with 10 stable, 13 guided, and 4 expert-review routes.
- 22 independently written visual patterns derived from generalized design methods, without copying third-party images or full prompts.
- Two-stage project approval: approve the bounded plan, then approve one visual anchor before the remaining paid batch.
- Creative brief, asset plan, and deliverables schemas.
- Offline `validate-workflow-plan` tool with catalog, approval-state, dependency, output-path, and expert-review checks.
- Intent-routing and workflow-plan fixtures; offline suite now covers project contracts in addition to engine safety.

### Changed
- Main and generated skills infer user outcomes instead of requiring users to choose commands or kinds.
- Existing XHS, article, and deck playbooks now use the shared plan/anchor approval protocol.
- README and architecture docs lead with complete creative outcomes while preserving Plan C as an expert shortcut.

## [0.5.4] — 2026-08-10

### Fixed
- Paid image `POST` requests are single-attempt: no automatic retry after timeout, `429`, or `5xx` responses.
- `--n` now strictly accepts positive integers and rejects values other than `1`, preventing paid results from being silently discarded.
- Generation refuses an existing output unless `--force` is explicit, writes through a same-directory temporary file, and atomically renames on success.
- URL-only API responses fail safely; the CLI only accepts the requested `b64_json` payload and does not fetch a server-provided URL.
- Config files with any group/other permissions are rejected; `$TZAI_IMAGE_CONFIG` must be an existing regular file.
- Temporary response, request, and output files are cleaned up on all exit paths.
- Generated skills and commands carry ownership markers; regeneration preserves handwritten files and rejects symlink output paths.
- Slash command installation preserves existing files by default; `--prune` removes only stale symlinks owned by this repository.
- Offline tests run in a disposable skill/config tree and cover paid-request, output, config, generator, and installer safety contracts.

## [0.5.3] — 2026-08-10

### Added
- `--ref` / `--reference` (repeatable): reference-guided generate via `/v1/images/edits`
- Workflows: `article-illustrate.md`, `slide-deck.md` (multi-image agent playbooks)
- Optional live smoke: `TZAI_LIVE=1 bash tests/run.sh`

### Changed
- SKILL.md documents multi-image workflows + `--ref`

## [0.5.2] — 2026-08-10

### Added
- HTTP retries with backoff for generate (`429` / `502` / `503` / `504`)
- Kind alias `product` → **`product-photo`** (商品摄影 vs hub 产品设计)
- GitHub Actions CI (`tests/run.sh`)

### Changed
- Canonical catalog kind id for product photography: `product-photo`
- Docs/README clarify hub `/tzai-product` (UX) vs `product-photo` (catalog)

## [0.5.1] — 2026-08-10

### Fixed
- Config load no longer `source`s shell files (KEY=value allowlist only)
- Invalid `--ar` rejected with supported list
- `--json` output safe for special characters in prompts
- `init` writes plain KEY=value; doctor uses `mktemp`
- `gen-demos.sh` hard-fails without API key
- AGENTS.md / CONTRIBUTING.md refreshed to current architecture

## [0.5.0] — 2026-08-10

### Added
- Plan C slash surface (engine + 6 hubs + 11 high-freq kinds)
- Scene matrices: xhs style×layout×palette, infographic layout×style, cover 5 dimensions
- Teaching gallery demos + TaoziAPI screenshots
- Multi-agent install helpers

### Changed
- Public docs present tzai-image as standalone TaoziAPI skill

## [0.4.0] — 2026-08-10

### Added
- Plan C whitelist-driven thin skills generation

## [0.3.0] — earlier

### Added
- Scenario kinds catalog, multi-agent slash packaging baseline
