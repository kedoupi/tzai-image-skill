# Diagram And Editorial Explanation

## `infographic-explainer`

### Problem / When
Explain one claim with a scannable visual structure (steps, comparison, funnel, timeline, hierarchy, metrics).

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| one_claim | Single message | Onboarding has three gates before activation |
| audience | Who reads it | Product managers |
| structure | steps / compare / funnel / timeline / hierarchy / metrics | steps |
| modules | 3–5 units: short title + optional one phrase | Discover → Setup → Activate |
| style_direction | Report / tech / education | Tech schematic, white ground |

### Optional slots
| Slot | Example |
| --- | --- |
| verified_numbers | Only if user-supplied |
| metaphor | journey path, funnel, building blocks |
| language | zh / en for short labels |

### Prompt compile order
1. **Claim** — one sentence topic for the graphic  
2. **Structure** — named layout + reading order  
3. **Modules** — exactly 3–5, each short  
4. **Visual system** — palette, icon style, spacing  
5. **Labels** — short only; language locked  
6. **Constraints** — AR, negatives, no dense body copy  

### Defaults
- Kind: `infographic` (or `flowchart` / `diagram` when process-first)
- AR: `16:9` default; use matrix `layout`/`style` when set
- Module count: clamp to 3–5

### Negatives
No long paragraphs inside the image; no invented statistics; no tiny unreadable axis text; no watermark; no cluttered card soup beyond module cap.

### Text policy
Short labels only. Long explanation, sources, and legal claims stay in external text (article, deck notes).

### Chinese labels
When the user works in Chinese: write module titles in Chinese; require readable Chinese characters; forbid random English gibberish mixed in label slots.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Too dense | Cut to 3 modules; increase whitespace |
| Fake numbers | Remove metrics; keep structure only |
| Unclear order | Explicit left-to-right or top-down + numbered steps |
| Wrong tone | Switch style_direction (report vs education) |

### Checks before approve
One claim obvious; modules ≤5; reading order clear; facts user-approved.

### Boundaries
Not a substitute for cited research. For verified science scale comparisons use `scientific-scale`.

### Example compiled prompt
```text
Infographic claim: new-user activation has three clear gates.
Audience: product managers. Structure: left-to-right steps with numbered modules.
Modules (exactly 3): 1 Discover product value · 2 Complete setup · 3 Reach first success.
Style: publication-ready tech schematic, modular grid, slate-teal icons, white background, generous spacing.
Labels: short English only as listed; no body paragraphs; no invented metrics.
Constraints: 16:9, clean hierarchy, no watermark, no dense fake text.
```

---

## `scientific-scale`
Use a supplied, verified scale reference and state whether the image is literal, logarithmic, or conceptual. Pair familiar comparators with clear entities and preserve stated ratios. Prefer `diagram` or `infographic`; never invent units, findings, or biological properties.
