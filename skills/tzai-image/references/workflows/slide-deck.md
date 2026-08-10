# Workflow: Multi-page slide deck visuals

Use when the user wants a **set of presentation visuals** (not only one title slide).

Assumption: slides are **readable / shareable** (self-explanatory cards), not live-speaker-only sparse slides.

## Agent steps

1. **Ingest** outline or article.
2. **Deck plan** (5–12 pages max for one batch):
   - page role: title | section | content | diagram | closing
   - one idea per page
   - subject line for image gen
3. **Shared visual system** (one line):  
   e.g. `McKinsey deep navy + gold hairline, vast title space, no body paragraphs`
4. **Confirm** page list unless 直接生成.
5. **Generate**:
   - page 1: `slide` (title) — style anchor
   - later pages: same style token; use `slide` / `infographic` / `flowchart` / `architecture` by role
   - optional `--ref` first page for consistency
6. Deliver ordered PNG paths + suggested on-slide title (text layered by user in PPT).

## CLI sketch

```bash
E=~/.agents/skills/tzai-image/scripts/tzai-image
SYS="premium consulting deck navy geometry gold hairline, empty title band, no dense body text"

bash $E slide --prompt "Title: $TOPIC. $SYS" --image ./slides/01-title.png
bash $E slide --prompt "Section: Market. $SYS" --image ./slides/02-section.png
bash $E infographic --layout metrics --style clean-corporate \
  --prompt "KPI overview for $TOPIC. $SYS" --image ./slides/03-metrics.png
bash $E flowchart --prompt "Go-to-market steps … $SYS" --image ./slides/04-flow.png
```

## Kind by page role

| Role | Kind |
| --- | --- |
| Title / closing | `slide` |
| Section divider | `slide` |
| Metrics wall | `infographic` |
| Process | `flowchart` |
| System | `architecture` |
| Product shot | `ui` / `product-photo` |

## Limits

- One visual idea per page.
- Prefer **title-safe empty areas** — user adds final Chinese titles in PPT if model text is unreliable.
