# Workflow Catalog

Workflows describe useful user outcomes; kinds describe single rendering primitives. The source of truth is [`skills/tzai-image/references/workflows/index.tsv`](../skills/tzai-image/references/workflows/index.tsv).

## Runtime Contract

1. Infer the outcome from natural language; do not ask the user to choose a workflow or kind.
2. Read only the selected guide plus its referenced modules and patterns.
3. For a project, present the bounded content/asset plan before paid generation.
4. After plan approval, generate exactly one anchor.
5. Generate the remaining approved assets only after anchor approval.
6. Deliver content, ordered images, and their mapping; preserve successful files on partial failure.

## Statuses

| Status | Count | Meaning |
| --- | ---: | --- |
| `stable` | 10 | Complete intake, plan, approval, production, and deliverable contract |
| `guided` | 13 | Usable with documented boundaries and closer review |
| `expert-review` | 4 | Requires explicit rights, factual, policy, or professional review |

## Stable Workflows

| ID | Outcome |
| --- | --- |
| `ui-flow` | One UI screen or a coordinated 1-8 screen product flow |
| `xhs-note` | Complete Xiaohongshu note copy, cover, and card series |
| `wechat-article` | Header and optional section visuals for an existing WeChat article (body stays in wechat-mp) |
| `article-illustrate` | Real-heading illustration plan, images, captions, and alt text |
| `brand-starter` | Identity direction, moodboard, mark concepts, and touchpoint notes |
| `product-launch` | Product hero and coordinated launch-channel assets |
| `campaign-kit` | Key visual plus campaign format variants |
| `knowledge-visual` | Fact-grounded infographic, diagram, flow, or data visual |
| `deck-package` | Ordered slide narrative and coordinated visual package |
| `character-ip` | Original character anchor, poses, and application concepts |

## Guided Workflows

`ecommerce-listing`, `packaging-retail`, `photography-direction`, `editorial-publication`, `education-module`, `illustration-system`, `storyboard`, `architecture-space`, `hospitality-exhibition`, `travel-map`, `document-report`, `product-rd`, and `speculative-design`.

## Expert-Review Workflows

| ID | Required boundary |
| --- | --- |
| `heritage-cultural` | Source ledger, uncertainty labels, and subject review |
| `personalized-beauty` | Consent, privacy, and no medical or diagnostic claims |
| `social-screen-mockup` | Synthetic data and clear non-evidence/mockup framing |
| `signature-exploration` | Originality review and no authentication/legal-signature use |

## Artifacts

Projects use reviewable artifacts:

```text
project/
  brief.json
  plan.md
  content.md
  asset-plan.json
  deliverables.json
  assets/
```

Validate plans offline with `skills/tzai-image/scripts/validate-workflow-plan` before anchor or batch generation.
