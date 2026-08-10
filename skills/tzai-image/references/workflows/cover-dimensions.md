# Workflow: Article cover (5 dimensions)

Inspired by baoyu-cover-image. Prefer **title-safe empty areas** over long baked-in Chinese titles (AI text is unreliable).

## Dimensions

| Flag | File | Default |
| --- | --- | --- |
| `--type` | cover-types.tsv | `hero` |
| `--palette` | cover-palettes.tsv | `cool` |
| `--rendering` | cover-renderings.tsv | `digital` |
| `--text` | cover-text.tsv | `title-only` |
| `--mood` | cover-moods.tsv | `balanced` |

## Agent flow

1. Infer type/palette/mood from article topic, or ask once.
2. Default `--text title-only` or `none` for best quality.
3. Generate; if text is wrong, regenerate — never patch pixels.

```bash
bash $E cover --type hero --palette dark --mood bold --text none \
  --prompt "分布式系统可观测性" --image cover.png
```
