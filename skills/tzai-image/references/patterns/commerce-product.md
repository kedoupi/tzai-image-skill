# Commerce And Product

## `product-commerce`

### Problem / When
Catalog hero, lifestyle product shot, packaging concept, or benefit-led commercial still. Source of truth is the real product (photos or verified specs).

### Required slots
| Slot | Question | Example |
| --- | --- | --- |
| product | What is sold | Matte black wireless earbuds case |
| angle | Hero view | 3/4 front, lid slightly open |
| surface | Ground / set | Seamless light gray infinity |
| lighting | Studio recipe | Dual softbox + soft rim |
| composition | Catalog / lifestyle / benefit-led | Catalog hero, product large |

### Optional slots
| Slot | Example |
| --- | --- |
| materials | Soft-touch plastic, metal hinge |
| props | Minimal; only if they clarify use |
| benefit_cue | Visual only (no price text) |
| brand_cues | Color accents matching brand |

### Prompt compile order
1. **Product identity** — accurate form and materials  
2. **Angle + scale** — product recognition first  
3. **Surface + lighting**  
4. **Composition role** — catalog vs lifestyle  
5. **Optional props / benefit cue**  
6. **Constraints** — no false claims, no price, no watermark  

### Defaults
- Kind: `product-photo` (banner/poster only for campaign crops)
- AR: `1:1` catalog; channel overrides allowed
- Prefer fewer props than more

### Negatives
Do not invent features, colors, or included items; no price/discount text; no fake certifications; no cluttered lifestyle that hides the SKU; no watermark.

### Text policy
Price, claims, ingredients, and legal lines are external. Image may stay text-free.

### Failure modes → retry
| Failure | Change |
| --- | --- |
| Looks cheap | Stronger lighting + material adjectives; cleaner surface |
| Wrong product | Re-state color, shape, distinctive parts; drop props |
| Busy | Remove lifestyle clutter; return to infinity set |
| Claim risk | Strip benefit text; visual only |

### Checks before approve
Product recognizable; materials plausible; no unverified claim text.

### Boundaries
Not a substitute for real pack shots when regulations require photography of the actual SKU.

### Example compiled prompt
```text
Luxury commercial product photo of matte black wireless earbuds charging case, lid slightly open revealing earbuds.
Angle: 3/4 front hero, product large and centered. Surface: seamless light gray infinity. Lighting: dual softbox + soft rim, micro surface detail.
Composition: catalog hero, minimal props, advertising quality materials.
Constraints: 1:1, no text, no price, no watermark, do not invent extra accessories, preserve proportions.
```

---

## `personalized-recommendation`
Show a user goal, a recommendation moment, and a concise explanation cue, not individual data. Use synthetic profiles and consent-safe examples. Do not depict sensitive inference, hidden scoring, or real account details.
