# tzai-image

[One-line description of what this skill does.]

## Install

```bash
npx skills add kedoupi/tzai-image-skill -g --all
```

## Prerequisites

1. [List required CLIs / auth / permissions]

## Quick start

```bash
# One-time config after install
bash <skill-dir>/scripts/tzai-image init --chat-id <id>

# Preview (local only — no side effects)
bash <skill-dir>/scripts/tzai-image --dry-run --title "Hello" --body "- item"

# Run
bash <skill-dir>/scripts/tzai-image --title "Hello" --body "World"
```

## Features

- ...

## Repository layout

```text
skills/
  tzai-image/
    SKILL.md
    config.example.env
    scripts/
      tzai-image       # main CLI
    templates/
tests/
  run.sh
```

## Development

```bash
bash tests/run.sh
npx skills add ./ --list
```

## License

[MIT](./LICENSE)
