# Creative Workflow Architecture

tzai-image is an agent-led creative system: the user describes an outcome in natural language, and the agent turns that intent into a scoped creative job. The CLI remains the reproducible rendering boundary; the agent owns clarification, routing, planning, review, and artifact handoff.

## Natural-Language-First Routing

Do not require users to know a command, kind, or preset. Route from the requested outcome:

| User intent | Agent route |
| --- | --- |
| "Make an app icon" | `icon` |
| "Explain our signup funnel" | `flowchart` or `infographic` |
| "A five-card Xiaohongshu series" | XHS project workflow |
| "Illustrate this article" | article project workflow |
| "Make a campaign look" | brief first; then `cover`, `banner`, `poster`, or photo/illustration |

The agent infers a kind from subject and delivery channel, applies a documented matrix or pattern when useful, and asks only for missing decisions that materially change the result: audience, format, brand constraints, language, required copy, or source assets. A known high-frequency scene may use a direct slash skill; category hubs and the engine remain the fallback for broad or long-tail work.

## Single vs. Project Workflows

**Single workflow** is for one independently useful image. The agent selects a kind, composes a concise production brief, previews the request when needed, and produces one image artifact with its render record.

**Project workflow** is for a coordinated set: a social series, article illustration package, slide deck, campaign family, or identity exploration. The agent first creates a content plan, establishes shared visual rules, then renders named items in sequence. Later items may use approved earlier outputs as `--ref` anchors where appropriate.

Project work is not a batch of unrelated prompts. It has a shared brief, asset manifest, ordering, and acceptance criteria so content and images remain consistent.

## Two-Stage Approval

Paid generation is deliberate. The architecture separates two decisions:

1. **Plan approval:** confirm the objective, audience, content structure, exact asset list, output paths, key constraints, and proposed visual direction before any paid render.
2. **Anchor approval:** generate exactly one approved anchor after plan approval. Confirm that image before producing any remaining assets in the bounded batch.

Clear user instructions can satisfy plan approval only after the bounded scope is visible. A multi-asset workflow never skips anchor approval. Ask again only when the scope changes or replacement of an existing output remains ambiguous. `--dry-run` is the inspection path when a request needs verification without side effects.

## Content and Image Artifacts

Every workflow should leave reviewable artifacts, not just pixels:

| Artifact | Purpose |
| --- | --- |
| Creative brief | Intent, audience, channel, constraints, success criteria |
| Content plan | Titles, claims, slide/card order, required copy, or narrative beats |
| Render plan | Kind, aspect ratio, matrix choices, references, and output paths |
| Image artifact | Generated image at its agreed path |
| Render record | Final prompt intent, parameters, model, and approval context |

For a single image, the brief and render record can be compact. For a project, retain a manifest that connects each content item to its image file and shared visual system.

## Responsibilities

| Layer | Responsibility |
| --- | --- |
| User | Goal, source material, business facts, brand ownership, approvals |
| Agent | Intent routing, brief, content structure, pattern selection, approval gates, quality review |
| tzai-image | Deterministic request construction and image generation through TaoziAPI |

The agent must not invent business facts, claim rights to user-supplied references, or silently spend credits. The system should favor clear deliverables and reproducible decisions over opaque prompt dumping.

The plan validator enforces readiness for agent-managed anchor and batch work. The low-level single-image CLI intentionally remains directly callable; invoking it explicitly approves only that one request and never authorizes an unbounded project batch.
