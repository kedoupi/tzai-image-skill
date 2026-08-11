# UI Flow

Use for requests such as "design an onboarding flow," "make a dashboard journey," or "visualize these product screens." Produce 1-8 related concept screens, not a working application.

## Intake

Infer the product, user, primary task, platform, and likely screen sequence from the request or source material. Ask only for material gaps: target user, required screens or states, brand constraints, or whether the output is `ui` or lower-fidelity `wireframe`. Use synthetic, clearly non-identifying data.

## Plan And Approval

Create a compact screen map before any paid call:

| # | Screen role | User goal | Key state/content | Kind |
| --- | --- | --- | --- | --- |
| 1 | Primary screen | Complete core task | Shared visual system | `ui` or `wireframe` |
| 2-N | Supporting screens | Continue flow | State-specific content | `ui`, `wireframe`, or `onboarding` |

State the shared component, color, type, spacing, and synthetic-data system. Identify exactly one primary screen as the anchor. Obtain explicit approval of this plan before paid generation.

## Two-Stage Production

1. Generate exactly one approved primary-screen anchor using an existing `ui`, `wireframe`, or `onboarding` kind.
2. Show it and obtain explicit anchor approval before any remaining paid assets.
3. Generate the approved supporting screens with the same system and the anchor through `--ref`. Keep each screen's task and state distinct.

## Delivery

Return ordered image files, a screen map, and handoff notes: platform assumption, screen purpose, visible state, reusable components, and suggested overlay copy. Name files in screen order.

## Quality And Boundaries

- Put final UI copy, dense tables, code, and exact values in the implementation layer; generated text is a draft and must be checked.
- Regenerate a single failed or off-system asset from the approved anchor; keep successful assets and report partial completion.
- These are visual concepts, not interaction specs, accessibility certification, production UI, or evidence of real users or data.
