# Single-Image Prompt Compile Guide (v0.6.1+)

Use after routing to a **kind** and optional **pattern**. Do not dump a one-line prose request into the CLI when a production pattern applies.

## Steps

1. Infer outcome → `single` vs `project` (projects use workflows; stop here).
2. Pick `kind` (+ matrix flags when relevant).
3. Match `references/patterns/index.tsv` → open the pattern doc.
4. Fill **required slots**. Ask at most 1–3 questions for missing slots that change the result.
5. If aesthetic direction is ambiguous, offer **2–3 short directions**, then compile.
6. Build `--prompt` in the pattern’s **compile order**.
7. Append **negatives** + **text policy** (and Chinese social lock when applicable).
8. Optional `--dry-run`, then one paid `generate`. Never auto-retry failures.

## Global compile skeleton

```text
[Subject / task]
[Structure / layout / hierarchy]
[Visual system: style, palette, materials, light]
[Content: short labels only, language locked]
[Format: aspect ratio, fidelity]
[Constraints / negatives]
```

## Chinese social lock

For `xhs`, `xhs-cover`, `wechat` (and `document-publishing` social roles) when copy is Chinese, always include the lock from `editorial-publishing.md`.

## Raw escape hatch

User may request a free-form / raw prompt. Then skip slot compile, still keep safety (no secrets, no auto-retry, confirm path when unclear).
