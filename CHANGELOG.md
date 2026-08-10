# Changelog

All notable changes to **tzai-image-skill** are documented here.

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
