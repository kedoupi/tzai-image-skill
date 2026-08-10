---
name: tzai-image
description: >
  Use when the user wants to generate or draw images via TaoziAPI (tzai.kdp.cool):
  icons, logos, flowcharts, architecture diagrams, infographics, Xiaohongshu/小红书 cards,
  WeChat visuals, UI mocks, wireframes, posters, covers, product photos, mascots, or any
  text-to-image job. Triggers: 画图, 生图, 图标, Logo, 流程图, 架构图, 信息图, 小红书,
  配图, diagram, infographic, xhs, icon, logo, draw, image gen, tzai, TaoziAPI, /tzai-image.
  Prefer --kind or kind subcommands (icon|flowchart|xhs|infographic|...). Not for Feishu push.
metadata:
  author: kedoupi
  version: "0.2.0"
---

# tzai-image

Generate images through **TaoziAPI** (`https://tzai.kdp.cool`) with **scenario kinds**
(分类功能) — same idea as baoyu's xhs / infographic / diagram skills, one CLI engine.

Default model: **`gpt-image-2`**.

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

## Scenario kinds (分类功能)

List and details:

```bash
bash <skill-dir>/scripts/tzai-image kinds
bash <skill-dir>/scripts/tzai-image kinds flowchart
```

| Category | Kinds | Use when |
| --- | --- | --- |
| **brand** 品牌 | `icon` `logo` `moodboard` `mascot` `badge` `avatar` | App 图标、Logo、吉祥物、徽章、头像 |
| **diagram** 结构 | `flowchart` `architecture` `mindmap` `diagram` `infographic` `dataviz` | 流程图、架构图、思维导图、信息图（对齐 baoyu-diagram / infographic） |
| **product** 产品 | `ui` `wireframe` `empty-state` `onboarding` | 仪表盘、线框、空状态、引导页 |
| **marketing** 市场 | `slide` `banner` `email-header` `cover` `poster` | PPT 封面、投放、邮件头图、文章封面 |
| **social** 社交 | `xhs` `xhs-cover` `wechat` | **小红书图卡/封面**、微信配图（对齐 baoyu-xhs-images） |
| **photo** 影像 | `product` `photo` `landscape` `illustration` `storybook` `food` | 商品图、风光、插画、绘本、美食 |

Agent routing:

1. Map user intent → **kind** (e.g. 小红书 → `xhs`, 流程图 → `flowchart`)  
2. Put **subject only** in `--prompt` (kind injects professional art direction + default `--ar`)  
3. Run generate  

```bash
# Kind API (recommended)
bash <skill-dir>/scripts/tzai-image generate \
  --kind icon --prompt "spark for AI coding app" --image ./icon.png

# Kind as subcommand (same as baoyu-style scene entry)
bash <skill-dir>/scripts/tzai-image flowchart \
  --prompt "注册 → 激活 → 付费" --image ./flow.png

bash <skill-dir>/scripts/tzai-image xhs \
  --prompt "三步写好周报" --image ./xhs-card.png

bash <skill-dir>/scripts/tzai-image infographic \
  --prompt "Q1 增长四要素" --image ./info.png
```

Raw generate without kind still works for free-form prompts.

## Usage

```bash
bash <skill-dir>/scripts/tzai-image doctor
bash <skill-dir>/scripts/tzai-image kinds

bash <skill-dir>/scripts/tzai-image generate \
  --dry-run --kind logo --prompt "几何 N monogram 靛蓝青绿" --image /tmp/logo.png

bash <skill-dir>/scripts/tzai-image architecture \
  --prompt "客户端 / 网关 / 微服务 / DB / 队列" --image ./arch.png
```

## Key CLI

```text
kinds [id]
init --api-key <sk> [...]
doctor [--strict-auth]
which-config | config-path
models
generate --kind <id> --prompt <text> --image <path> [--ar] [--model] [--dry-run] [--json]
<kind> --prompt <text> --image <path>   # alias, e.g. icon|flowchart|xhs|infographic
--version
```

Catalog file: `references/kinds.tsv` (edit to add kinds without rewriting the script).

## Troubleshooting

1. `doctor` and fix `[FAIL]` lines  
2. Confirm key at https://tzai.kdp.cool/console  
3. Wrong scene quality → pick a better `--kind` (`kinds` list)  
4. `which-config` to see whether key comes from `env` vs `file`  
