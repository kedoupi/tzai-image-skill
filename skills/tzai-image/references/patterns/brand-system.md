# Brand System

## `brand-identity`

### Problem / When
Explore a new brand direction: mark, monogram, palette, materials, and tone — not final trademark clearance.

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| brand_idea | One positioning idea | Calm precision for developer tools |
| audience | Who it serves | Indie hackers and small product teams |
| differentiator | Why not generic | Quiet geometry, no neon startup cliché |
| deliverable | logo board / icon / moodboard | Logo monogram exploration |
| palette_intent | Color direction | Deep indigo + soft mint |

### Optional slots
| Slot | Example |
| --- | --- |
| materials | Paper, brushed metal, glass |
| applications | App icon adjacency, card mock (directional) |
| mark_type | Wordmark / monogram / symbol |

### Prompt compile order
1. **Brand idea + audience**  
2. **Mark direction** — geometry, negative space  
3. **Palette + materials**  
4. **Board composition** — clean presentation  
5. **Constraints** — originality, no slogan unless asked  

### Defaults
- Kind: `logo` or `moodboard` / `icon` by deliverable
- AR: `16:9` boards; `1:1` icons
- Project path: `brand-starter` workflow for multi-asset kits

### Negatives
No imitation of protected marks; no random unrelated logo variants on one board unless requested as options; no fake trademark symbols as “approved”; no watermark; no dense slogan paragraphs.

### Text policy
Avoid generated taglines. Brand name only if user supplied and short.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Generic startup look | Strengthen differentiator + materials |
| Too many marks | Single hero mark, fewer options |
| Clashing palette | Lock 2–3 colors only |
| Looks like known brand | Explicit “original geometry, not similar to X” without copying X |

### Checks before approve
One clear idea; mark legible at small size; originality review still needed.

### Boundaries
Not legal clearance. Not final SVG production files.

### Example compiled prompt
```text
Premium brand logo exploration board for a developer-tools brand idea: calm precision.
Audience: indie hackers. Differentiator: quiet geometry, Swiss discipline, no neon cliché.
Mark: geometric monogram on pure white, razor-sharp vector edges, ample negative space, subtle soft shadow only under the mark.
Palette intent: deep indigo with soft mint accent. Presentation: identity-system final-art quality, single focused mark.
Constraints: 16:9, no slogan, no watermark, original mark only, no imitation of known logos.
```

---

## `brand-touchpoint`
Start with approved logos, colors, type, and voice. Map each asset to its touchpoint role, with shared spacing and image treatment. Generate direction boards only; place production marks and copy with approved source files.
