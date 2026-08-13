# WeChat Article Visuals

Use when an **existing** WeChat Official Account article needs a header and optional section visuals: “add a cover to this 公众号稿,” “illustrate this wechat-mp-out slug,” or “package visuals for an already-written WeChat post.”

**Does not own the article body.** If the user asked to write, rewrite, or draft 公众号正文, hand off to **wechat-mp** first (Mode A). Resume this workflow only after `article.md` (or equivalent source text) exists.

Produce 1-8 image assets: one header visual and up to seven section visuals.

## Intake

Prefer an existing content project:

```text
<project>/wechat-mp-out/<slug>/
  manifest.json
  brief.md
  article.md
  cover.png          # this workflow writes here
  figures/
```

Read the supplied `article.md` (or wechat-mp brief) and infer audience, heading structure, and visual opportunities. Ask only for material gaps: source article path, verified facts, mandatory brand rules. Do not rewrite the article and do not create a second `article.md`.

## Plan And Approval

Prepare an approved **visual map** against the existing article before paid calls:

| Placement | Heading/purpose | Content point | Visual approach | Kind | Output |
| --- | --- | --- | --- | --- | --- |
| Header | Article promise | Opening idea | Header visual | `wechat` | `cover.png` (or `wechat-mp-out/<slug>/cover.png`) |
| Optional sections | Specific heading | One verified point | Illustration or explanation | `illustration` or `infographic` | `figures/` |
| Optional share asset | Distribution hook | Short promise | Editorial cover | `cover` | extra file, not a second article |

Name exactly one header visual as the anchor and obtain explicit plan approval.

## Two-Stage Production

1. Generate exactly one `wechat` header anchor.
2. Obtain explicit anchor approval before remaining paid assets.
3. Create approved optional `illustration`, `infographic`, or `cover` assets with `--ref` to the anchor. Match the article's existing headings, not merely its keywords.

## Delivery

Return the header file, optional numbered section files, and a placement map with filename, heading, caption, and alt text. If a wechat-mp output dir is in use, write `cover.png` / `figures/` there and leave `article.md` untouched. Include only the approved 1-8 assets.

If `wechat-mp` is installed, the agent may run `wechat-mp manifest-set --dir "$OUT" --status visual=done` after images land. Preview and draft stay in wechat-mp.

## Quality And Boundaries

- Keep detailed labels, citations, and final Chinese copy in the **existing** article; check rendered on-image text for fidelity and regenerate poor text.
- Preserve completed assets if one fails; report its placement and resume only after the corrected asset is approved when it affects the series.
- This is a visual package for an existing article, not writing, fact checking, legal review, WeChat HTML preview, or publication.
