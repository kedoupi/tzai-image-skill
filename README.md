# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

Generate images via **TaoziAPI** ([tzai.kdp.cool](https://tzai.kdp.cool)) from coding agents.

Install:

```bash
npx skills add kedoupi/tzai-image-skill
```

## Get an API key

This skill does **not** ship with a key.

1. Open [https://tzai.kdp.cool/console](https://tzai.kdp.cool/console)
2. Sign in / register and create an API token
3. Configure the key (pick one):

```bash
# A) Global environment variable (enough by itself)
export TZAI_API_KEY='sk-xxxxxxxx'

# B) Durable config (survives npx skills update)
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx

# C) One-shot flag on generate
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --api-key sk-xxxxxxxx --prompt "a cat" --image cat.png --model YOUR_MODEL
```

Never commit the key. Do not store it only inside the skill package directory.

## Quick start

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor

# List models (needs key)
bash ~/.agents/skills/tzai-image/scripts/tzai-image models

# Dry-run (no network)
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --dry-run --prompt "a red cube" --image /tmp/cube.png --model YOUR_MODEL

# Generate
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --prompt "a red cube" --image ./cube.png --ar 1:1 --model YOUR_MODEL
```

## Configuration

| Variable | Meaning | Default |
| --- | --- | --- |
| `TZAI_API_KEY` | API key | _(required for real calls)_ |
| `TZAI_BASE_URL` | Gateway | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | Default model id | _(set after `models`)_ |
| `TZAI_IMAGE_CONFIG` | Explicit env file | unset |
| `TZAI_DEFAULT_AR` | Aspect ratio | `1:1` |
| `TZAI_TIMEOUT_SEC` | HTTP timeout | `120` |

**Load order (later wins):** config files under `.skill-data` → **process env** → `$TZAI_IMAGE_CONFIG` → CLI flags.

So a global `export TZAI_API_KEY=...` works without `init`. If both file and env are set, **env wins**.

Inspect:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image which-config
```

## CLI

```text
init --api-key sk-... [--base-url] [--model] [--target durable|global|local] [--force]
doctor [--strict-auth]
which-config | config-path
models
generate --prompt ... --image out.png [--model] [--size] [--ar] [--api-key] [--dry-run] [--json]
--version
```

## Development

```bash
git clone https://github.com/kedoupi/tzai-image-skill.git
cd tzai-image-skill
bash tests/run.sh
```

## License

[MIT](./LICENSE)
