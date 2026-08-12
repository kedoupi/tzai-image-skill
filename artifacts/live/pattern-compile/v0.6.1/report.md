# Live report: pattern-compile v0.6.1

- Suite: `tests/live/pattern-compile/`
- Model: `gpt-image-2` via TaoziAPI
- Generated: 2026-08-11
- Layout: `pairs/<case-id>/{before,after}.png`

## Summary

| Metric | Result |
| --- | --- |
| Pairs | 12 (24 images) |
| Live generate | 24/24 OK |
| Spec-match winner | after **12/12** |
| Pure aesthetics | often close (kind prefixes already strong) |

## Per-case notes

| Case | Kind | Winner | Note |
| --- | --- | --- | --- |
| 01-ui | ui | after | KPI→chart→table hierarchy |
| 02-infographic | infographic | after | no invented metrics |
| 03-xhs | xhs | after | exact Chinese steps |
| 04-poster | poster | after | title-safe hero |
| 05-product | product-photo | after | lid open + earbuds |
| 06-logo | logo | after | N monogram + indigo/mint |
| 07-flowchart | flowchart | after | exact 4 steps (not 7 invented) |
| 08-wechat | wechat | after | title-safe header |
| 09-cover | cover | after | dark hero + text none matrix |
| 10-architecture | architecture | after | named services/data plane |
| 11-xhs-matrix | xhs | after | notion style + locked tips |
| 12-icon | icon | after | spark + bracket metaphor |

## Rubric

See `tests/live/pattern-compile/rubric.md`.

## Reproduce

```bash
bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.1 --force
```
