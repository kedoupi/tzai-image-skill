# Product Systems

## `ui-screen-system`

### Problem / When
Design one product screen or a coherent multi-screen set (dashboard, app home, onboarding). Prefer this pattern whenever platform chrome, hierarchy, or readable short labels matter.

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| platform | iOS / Android / Web / Desktop | Web SaaS |
| primary_task | One job the screen does | Review weekly metrics |
| layout | Structure | Left nav + KPI cards + chart |
| hierarchy | What is primary / secondary | Big KPIs → trend → table |
| visual_system | Theme and density | Light mode, 8pt spacing, slate-teal |

### Optional slots
| Slot | Example |
| --- | --- |
| states | default / empty / loading |
| visible_labels | short strings that may appear |
| data_policy | synthetic only |
| adjacent_screens | list for series after anchor |

### Prompt compile order
1. **Task** — product type + primary task  
2. **Platform + layout** — chrome, navigation, regions  
3. **Hierarchy** — focal region, secondary panels  
4. **Visual system** — theme, palette, density, component finish  
5. **Content** — only short approved labels / synthetic metrics  
6. **Constraints** — aspect ratio, fidelity, negatives  

### Defaults
- Kind: `ui` (or `wireframe` for flow decisions, `onboarding` for hero)
- AR: `16:9` web/dashboard; `9:16` mobile product
- Series: generate one anchor screen → approve → adjacent with `--ref`

### Negatives
No real PII; no unreadable garble buttons; no mixed platform chrome; no dense paragraphs in cards; no watermark; do not claim working software.

### Text policy
Prefer short labels only. Final product copy and real metrics live outside the image when accuracy matters.

### Chinese / mixed UI
If labels are Chinese: list exact short strings in the prompt; require readable Chinese; forbid placeholder Latin gibberish on buttons.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Garbled text | Fewer labels; list exact strings; increase “readable short labels only” |
| Wrong platform look | Lock platform + chrome explicitly |
| Clutter | Drop secondary panels; reduce card count |
| Inconsistent series | Reuse approved anchor with `--ref` + same visual_system token |

### Checks before approve
Primary task readable at a glance; navigation consistent; synthetic data only; AR matches device.

### Boundaries
Concept mock, not production Figma. Social-feed / live-stream clones → `social-screen-mockup` expert-review workflow.

### Example compiled prompt (English structure)
```text
Web SaaS analytics dashboard for reviewing weekly product metrics.
Platform: desktop web. Layout: left sidebar nav, top bar, main grid of 4 KPI cards, large line chart, compact table below.
Hierarchy: KPIs largest, then chart, then table. Light mode, 8pt spacing, slate-teal accents, Linear/Stripe polish.
Short labels only (synthetic): Overview, Users, Revenue, Retention, Last 7 days.
Constraints: 16:9, high-fidelity UI mock, crisp edges, no real PII, no watermark, no unreadable garble text, no dense paragraphs.
```

---

## `product-rd-breakdown`
Start from verified stages, owners, inputs, outputs, dependencies, and decision gates. Choose `flowchart` for sequence, `architecture` for technical relationships, or `infographic` for a stage overview. Make the process legible at a glance, then add approved labels externally. Do not expose confidential roadmap details or infer timelines.
