# Marketing And Campaign

## `poster-layout`

### Problem / When
Event, campaign, announcement, or cover-style poster where focal subject and title-safe zones matter more than body copy.

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| context | Where it is seen | Social story / print A3 / site hero |
| aspect | 9:16 / 16:9 / 1:1 | 9:16 |
| focal_subject | Single hero | Runner mid-stride silhouette |
| message | One line intent | Launch week energy (not full legal copy) |
| layout_zones | Title / subject / footer safe areas | Top title band, center subject, bottom quiet |

### Optional slots
| Slot | Example |
| --- | --- |
| palette | Deep navy + electric lime |
| finish | Photo-real / graphic / hybrid |
| brand_cues | Materials, accent lines (not unlicensed marks) |

### Prompt compile order
1. **Context + AR**  
2. **Focal subject** — scale and pose  
3. **Layout zones** — title-safe empty or reserved bands  
4. **Palette + finish**  
5. **Message intent** — mood, not long copy  
6. **Constraints / negatives**  

### Defaults
- Kind: `poster` (or `banner` / `cover` by channel)
- Prefer one focal subject dominating ~40–70% visual weight
- Production typography for final legal/title when accuracy matters

### Negatives
No noisy collage; no extra competing heroes; no dense paragraphs; no unlicensed logos; no watermark; no random decorative glyphs filling title zone.

### Text policy
Reserve text zones. Treat on-image lettering as directional unless user supplies exact short display words and accepts generation risk.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Subject too small | Explicit “subject 50–70% of frame” |
| Busy | Remove secondary props; simplify palette |
| Title crushed | Larger empty title-safe band |
| Wrong mood | Reset palette + finish only |

### Checks before approve
One clear hero; readable composition at thumbnail size; legal copy plan external if required.

### Boundaries
Not print-ready with mandatory disclaimers embedded. Sports talent rights → `sports-campaign`.

### Example compiled prompt
```text
Vertical campaign poster for a product launch week, 9:16 social story.
Focal subject: single anonymous runner mid-stride, sharp silhouette, dominating center frame.
Layout zones: large quiet top band for title overlay, clean mid hero, minimal bottom footer band.
Palette: deep navy, electric lime accent, high contrast, advertising finish, soft ground reflection.
Message intent: kinetic launch energy; no long body copy; no brand wordmarks unless supplied.
Constraints: one hero only, no collage, no watermark, no dense text, no unlicensed team marks.
```

---

## `sports-campaign`
Use a licensed athlete or an anonymous archetype, name the action and peak moment, then apply campaign palette and crop-safe space. Avoid team marks, endorsement implications, and impossible sports equipment details.

## `conceptual-typography`
Translate the concept into letterform behavior, scale, material, and negative space. Treat generated type as visual exploration only. Rebuild every essential word, date, and logo with licensed production fonts.
