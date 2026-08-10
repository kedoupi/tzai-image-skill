---
name: tzai-image
description: >
  Use when the user wants to generate or draw images via TaoziAPI (tzai.kdp.cool),
  create AI pictures, text-to-image, or configure TZAI_API_KEY for image generation.
  Triggers: 画图, 生图, 生成图片, draw, image gen, text-to-image, tzai, TaoziAPI,
  /tzai-image. Not for Feishu push (lark-push) or generic host-native image tools only.
metadata:
  author: kedoupi
  version: "0.1.1"
---

# tzai-image

Generate images through **TaoziAPI** (`https://tzai.kdp.cool`) using an OpenAI-compatible
Images API.

## Prerequisites (agents: check these first)

Run:

```bash
bash <skill-dir>/scripts/tzai-image doctor
```

| Need | Why | If missing |
| --- | --- | --- |
| **API key** | Gateway auth | User creates token at https://tzai.kdp.cool/console |
| **python3** | JSON + save image | `brew install python3` |
| **curl** | HTTP | macOS usually has it |
| **Default model** | Built-in **`gpt-image-2`** (best on this gateway) | Override with `--model` / `TZAI_IMAGE_MODEL` if needed |

### How users get and set the key

Skill install **does not** include a key. Never invent or hardcode keys.

1. Open https://tzai.kdp.cool/console → register/login → create API token  
2. Configure **one** of:

```bash
# A) Global env (enough by itself — no init required)
export TZAI_API_KEY='sk-...'

# B) Durable file (survives npx skills update)
bash <skill-dir>/scripts/tzai-image init --api-key sk-...

# C) One-shot flag
bash <skill-dir>/scripts/tzai-image generate --api-key sk-... --prompt "..." --image out.png
```

Do **not** put secrets only inside the skill package directory.

## Locating the helper

```text
~/.agents/skills/tzai-image/scripts/tzai-image
# or project / agent-specific skills path
```

Script uses `pwd -P` so symlinks resolve correctly.

## Config load order (later wins)

1. Built-in defaults (`BASE_URL=https://tzai.kdp.cool`)  
2. Config files under XDG / `.skill-data` / `config.local.env`  
3. **Process environment** `TZAI_API_KEY`, `TZAI_BASE_URL`, `TZAI_IMAGE_MODEL`, …  
4. File pointed by `$TZAI_IMAGE_CONFIG`  
5. CLI flags  

Inspect:

```bash
bash <skill-dir>/scripts/tzai-image which-config
bash <skill-dir>/scripts/tzai-image doctor
```

## Safety

- Confirm prompt and output path before real (paid) generation when unclear  
- Prefer `--dry-run` for request preview (no network)  
- User running the helper counts as approval for that invocation  
- Never commit API keys  

## Host-native image tools

If the host already has native image tools (e.g. Grok `image_gen`, Codex `imagegen`):

- Casual one-offs **in that host** may use the native tool  
- Use **tzai-image** when the user wants TaoziAPI, a reproducible CLI, CI, or durable `TZAI_*` config  

## Usage

```bash
# Environment check
bash <skill-dir>/scripts/tzai-image doctor

# Preview (local only)
bash <skill-dir>/scripts/tzai-image generate \
  --dry-run \
  --prompt "a red cube on a table" \
  --image /tmp/cube.png \
  --model YOUR_MODEL_ID

# Generate
bash <skill-dir>/scripts/tzai-image generate \
  --prompt "a red cube on a table" \
  --image ./out/cube.png \
  --ar 1:1
```

## Key CLI

```text
init --api-key <sk> [--base-url] [--model] [--target durable|global|local] [--force]
doctor [--strict-auth]
which-config | config-path
models
generate --prompt <text> --image <path> [--model] [--size] [--ar] [--api-key] [--dry-run] [--json]
--version
```

## Troubleshooting

1. `doctor` and fix `[FAIL]` lines  
2. Confirm key at https://tzai.kdp.cool/console  
3. `models` to pick a valid image model id  
4. `which-config` to see whether key comes from `env` vs `file`  
