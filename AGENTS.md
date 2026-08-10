# AGENTS.md

Guidance for AI coding agents working in this repository.

This file is the **source of truth**. Optional `CLAUDE.md` only points here.

## Purpose

Installable skill **`tzai-image`**: text-to-image via TaoziAPI (`https://tzai.kdp.cool`).

```bash
npx skills add kedoupi/tzai-image-skill
```

## Layout

```text
skills/
  tzai-image/
    SKILL.md
    config.example.env
    scripts/tzai-image
tests/
  run.sh
```

## Editing rules

- Keep `SKILL.md` under ~500 lines; strong description triggers.
- Never hardcode API keys or put secrets only in the package dir.
- Support **global env** `TZAI_API_KEY` without requiring `init`.
- Durable config: `<skills-parent>/.skill-data/tzai-image/config.env`.
- `--dry-run` must stay offline.
- `doctor` must print console URL + export/init examples when key missing.
- Bump `metadata.version` when behavior changes.
- Prefer bash + python3 + curl; no bun required for v0.1.

## Validation

```bash
bash tests/run.sh
bash skills/tzai-image/scripts/tzai-image doctor
bash skills/tzai-image/scripts/tzai-image generate \
  --dry-run --prompt "test" --image /tmp/t.png --model demo
```
