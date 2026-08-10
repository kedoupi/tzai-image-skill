# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

Generate images from coding agents via **TaoziAPI** ([tzai.kdp.cool](https://tzai.kdp.cool)).

Default model: **`gpt-image-2`** (best image model on this gateway).  
Works with Claude Code, Codex, Cursor, Grok Build, and other agents via the [skills CLI](https://skills.sh/).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-kedoupi%2Ftzai--image--skill-181717?logo=github)](https://github.com/kedoupi/tzai-image-skill)

<p align="center">
  <img src="docs/screenshots/product-cube.png" alt="Product photo example" width="280" />
  <img src="docs/screenshots/illustration-story.png" alt="Storybook illustration example" width="280" />
</p>

## What can you generate?

All samples below were produced with this skill (`gpt-image-2`, TaoziAPI). Copy the command and try your own prompt.

### Product / catalog (1:1)

Studio product shot — e-commerce, mockups, packaging concepts.

![Product cube](docs/screenshots/product-cube.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./product.png \
  --prompt "Product photo of a glossy red cube on pure white seamless background, soft studio lighting, subtle reflection, commercial catalog style"
```

### Landscape / cinematic (16:9)

Wide scenes for slides, blog headers, thumbnails.

![Landscape dawn](docs/screenshots/landscape-dawn.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 \
  --image ./landscape.png \
  --prompt "Wide cinematic landscape at golden hour: misty mountain lake, warm sunrise, pine forest silhouette, volumetric fog, National Geographic style"
```

### Poster / social vertical (9:16)

App promo, Stories, short-video covers.

![Tech poster](docs/screenshots/poster-tech.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 9:16 \
  --image ./poster.png \
  --prompt "Vertical tech poster for an AI coding agent, dark navy gradient, neon cyan accents, abstract neural circuit motif, clean minimal UI aesthetic"
```

### Storybook illustration (1:1)

Children’s books, narrative art, soft illustration.

![Story illustration](docs/screenshots/illustration-story.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./story.png \
  --prompt "Whimsical storybook illustration of a small robot reading under a giant mushroom, soft watercolor, pastel palette, children's picture book style"
```

### Workflow / diagram style (16:9)

Process explainers for docs and decks (raster illustration, not Mermaid).

![Workflow diagram](docs/screenshots/diagram-flow.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 \
  --image ./flow.png \
  --prompt "Clean flat infographic of a 4-step workflow left to right: Idea, Scaffold, Generate, Publish — soft rounded cards, muted blue-gray, white background"
```

### Food / lifestyle (1:1)

Lifestyle and food photography for content.

![Latte macro](docs/screenshots/food-macro.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./food.png \
  --prompt "Macro food photo of a ceramic latte cup with heart latte art, wooden table, morning window light, shallow depth of field"
```

### More prompt ideas

| Use case | Aspect | Prompt starter |
| --- | --- | --- |
| App icon concept | `1:1` | “Minimal app icon, rounded square, flat vector, single metaphor…” |
| Blog hero | `16:9` | “Editorial hero image, soft gradient, abstract shapes, no text…” |
| WeChat / XHS cover | `1:1` or `3:4` | “Bright lifestyle cover, high contrast, friendly illustration…” |
| Architecture sketch | `16:9` | “Isometric software architecture, labeled boxes as icons only…” |
| Character turnaround | `16:9` | “Same character front/side/back, clean white background…” |
| UI mock mood | `16:9` | “SaaS dashboard UI mock in light mode, glass cards, no real text…” |

Tip: say **style** (photo / watercolor / flat / isometric), **lighting**, **background**, and **what to avoid** (e.g. “no watermark, no unreadable fake text”).

## Install

```bash
npx skills add kedoupi/tzai-image-skill -g --all
```

## Get an API key

This skill does **not** ship with a key.

1. Open [https://tzai.kdp.cool/console](https://tzai.kdp.cool/console)
2. Sign in and create an API token
3. Configure (pick one):

```bash
# A) Global env (enough by itself)
export TZAI_API_KEY='sk-xxxxxxxx'

# B) Durable file (survives npx skills update)
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx

# C) One-shot
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --api-key sk-xxxxxxxx --prompt "a cat" --image cat.png
```

Never commit the key. Do not store it only inside the skill package directory.

## Quick start

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor

# Dry-run (no network) — default model gpt-image-2
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --dry-run --prompt "a red cube" --image /tmp/cube.png

# Generate
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --prompt "a red cube on white background, product photo" \
  --image ./cube.png \
  --ar 1:1
```

Optional: list models (default is already the best image model):

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image models
```

## Configuration

| Variable | Meaning | Default |
| --- | --- | --- |
| `TZAI_API_KEY` | API key | _(required for real calls)_ |
| `TZAI_BASE_URL` | Gateway | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | Image model | **`gpt-image-2`** |
| `TZAI_IMAGE_CONFIG` | Explicit env file | unset |
| `TZAI_DEFAULT_AR` | Aspect ratio | `1:1` |
| `TZAI_TIMEOUT_SEC` | HTTP timeout | `120` |

**Load order (later wins):** config files under `.skill-data` → **process env** → `$TZAI_IMAGE_CONFIG` → CLI flags.

So `export TZAI_API_KEY=...` alone is enough. Env overrides file when both are set.

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image which-config
```

### Aspect ratios

| `--ar` | Typical use | Request size mapping |
| --- | --- | --- |
| `1:1` | Product, avatar, square post | 1024×1024 |
| `16:9` | Landscape, slide, blog header | 1792×1024 |
| `9:16` | Stories, vertical poster | 1024×1792 |
| `4:3` / `3:4` | Classic photo / portrait | 1536×1152 / 1152×1536 |

Gateway may return slightly different pixel sizes; the file is still a valid PNG.

## CLI

```text
init --api-key sk-... [--base-url] [--model] [--target durable|global|local] [--force]
doctor [--strict-auth]
which-config | config-path
models
generate --prompt ... --image out.png [--model] [--size] [--ar] [--api-key] [--dry-run] [--json]
--version
```

## Agent usage

When the user asks to draw / generate an image:

1. Ensure key is configured (`doctor` if unsure).
2. Prefer this skill when they want **TaoziAPI** / reproducible CLI output.
3. Choose aspect from the use case (product → `1:1`, hero → `16:9`, story → `9:16`).
4. Write a concrete prompt (subject + style + lighting + background).
5. Run `generate` and report the output path.

## Development

```bash
git clone https://github.com/kedoupi/tzai-image-skill.git
cd tzai-image-skill
bash tests/run.sh
```

## License

[MIT](./LICENSE)

## Links

- GitHub: https://github.com/kedoupi/tzai-image-skill
- TaoziAPI: https://tzai.kdp.cool
- Incubator: https://github.com/kedoupi/skills
