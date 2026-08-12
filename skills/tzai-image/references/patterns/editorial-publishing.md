# Editorial And Publishing

## `history-classical`
Separate verified source material from visual interpretation. Provide period, place, objects, and uncertainty explicitly; use interpretive imagery rather than fabricated documentary certainty. Historians or subject experts should review factual details.

## `document-publishing`

### Problem / When
Article, report, WeChat, or knowledge-card systems where hierarchy and series consistency matter. Also used when compiling **Chinese social cards** (`xhs`, `wechat`) so short Chinese titles stay readable.

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| publication_role | cover / section / share card / header | XHS knowledge card |
| message | One scannable idea | Three steps to write a weekly report |
| hierarchy | Title → points → footer | Large title, 3 steps, quiet footer |
| format | Channel + AR | Xiaohongshu 3:4 |
| language | Label language | Chinese short titles |

### Optional slots
| Slot | Example |
| --- | --- |
| points | 3–7 short bullets max |
| series_token | Shared palette / motif name |
| style_matrix | xhs style/layout/palette ids |

### Prompt compile order
1. **Role + channel + AR**  
2. **Message** — one idea  
3. **Hierarchy** — title zone, body modules, footer  
4. **Points** — capped list of short lines  
5. **Visual system** — palette, icons, matrix style  
6. **Language lock + negatives**  

### Chinese social text lock (required for `xhs` / `xhs-cover` / `wechat` when copy is Chinese)

Always append constraints equivalent to:

```text
Chinese short titles and labels only; characters must be clear and readable;
no garbled text, no nonsense Latin filler, no dense paragraphs, no watermark;
keep module count small; title zone dominant for feed thumbnails.
```

Exact user-supplied title/points should be listed verbatim in the prompt when they must appear.

### Defaults
- Kinds: `cover`, `wechat`, `xhs`, `xhs-cover`, `illustration`, `infographic`
- Knowledge cards: prefer 3–5 points, not essays
- Multi-asset: shared series_token + anchor `--ref`

### Negatives
No body-copy walls; no fake citations in-image; no watermark; no random decorative glyphs; no overcrowded sticker chaos unless style requests it.

### Text policy
Typeset long titles, citations, and accessibility text in the publishing tool when accuracy is critical. Image holds hierarchy and short labels.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Unreadable Chinese | Fewer characters; larger title; restate exact strings |
| Too many points | Cap at 3–5 |
| Series drift | Anchor `--ref` + same palette/style ids |
| Looks like ad spam | Reduce stickers; increase whitespace |

### Checks before approve
Thumbnail: title readable; points count OK; language correct; claims verified outside image.

### Boundaries
Does not publish to platforms. Does not guarantee character-perfect typography for legal pages.

### Example compiled prompt (XHS)
```text
Xiaohongshu knowledge card, 3:4, magazine-grade hierarchy.
Role: educational share card. Message: three steps to write a solid weekly report.
Hierarchy: large Chinese title zone at top, three numbered step modules, quiet footer.
Exact short Chinese labels: 标题「三步写好周报」; 步骤「1 先写结论」「2 用数据支撑」「3 给下一步」.
Style: refined knowledge card, clean icons, sophisticated palette, not childish clipart.
Constraints: readable Chinese only as listed, no garbled text, no dense paragraphs, no watermark, minimal clutter.
```
