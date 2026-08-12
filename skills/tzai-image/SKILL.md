---
name: tzai-image
description: >
  Use for natural-language image creation and coordinated creative projects through TaoziAPI:
  single images, UI screen flows, complete Xiaohongshu notes, WeChat article packages, article
  illustration plans, brand starters, product launches, campaign kits, knowledge visuals, decks,
  character/IP systems, ecommerce, publishing, photography, storyboards, spaces, and cultural or
  R&D concepts. Triggers include 画图, 生图, 配图, UI设计, 小红书笔记, 公众号文章/封面, 逐章配图,
  品牌视觉, 商品发布, Campaign, 信息图, PPT视觉, 角色设定, 分镜, 空间概念, diagram, image gen,
  visual system, creative project, tzai, TaoziAPI, and /tzai-image. Infer workflows and kinds
  internally; do not require users to know commands. Not for publishing to social platforms.
argument-hint: "[kind] prompt…  e.g. xhs 三步写周报 / flowchart 注册到付费"
user-invocable: true
metadata:
  author: kedoupi
  version: "0.7.0"
  short-description: "TaoziAPI 创作 Agent（自然语言工作流 + 生图引擎）"
---

# tzai-image

Generate images through **TaoziAPI** (`https://tzai.kdp.cool`) with **scenario kinds**
— one CLI engine with scenario kinds, without installing dozens of packages.

Default model: **`gpt-image-2`**.

## Plan C slash surface

| Layer | Count | Examples |
| --- | --- | --- |
| **Engine** | 1 | `/tzai-image` (this skill) — any kind + doctor/kinds |
| **Category hubs** | 6 | `/tzai-brand` `/tzai-diagram` `/tzai-product` `/tzai-marketing` `/tzai-social` `/tzai-photo` |
| **High-freq kinds** | 11 | `/tzai-xhs` `/tzai-icon` `/tzai-flowchart` `/tzai-architecture` `/tzai-infographic` `/tzai-cover` `/tzai-slide` `/tzai-logo` `/tzai-ui` `/tzai-wechat` `/tzai-xhs-cover` |

**Long-tail kinds** (mindmap, mascot, food, banner, …) stay in `kinds.tsv` but **no thin slash skill** — call:

```bash
bash <skill-dir>/scripts/tzai-image mindmap --prompt "..." --image out.png
# or natural language → agent maps to kind
```

Whitelist: `references/slash-whitelist.txt`.

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

## Slash commands (multi-agent)

Install (global, all agents — pulls Plan C skill set only):

```bash
npx skills add kedoupi/tzai-image-skill -g --all
# optional command wrappers:
bash scripts/install-slash-commands.sh
```

| Client | Skills path (typical) |
| --- | --- |
| **Grok Build** | `~/.grok/skills/tzai-*` + `~/.agents/skills/tzai-*` |
| **Claude Code** | `~/.claude/skills/tzai-*` |
| **Codex / Cursor / others** | via `npx skills add --agent '*'` |

Examples:

```text
/tzai-icon 火花隐喻 AI 编程 App
/tzai-xhs 三步写好周报
/tzai-flowchart 注册 → 激活 → 付费
/tzai-diagram          ← category hub: pick flowchart / architecture / …
/tzai-image mindmap 产品战略拆解   ← long-tail kind via engine
```

Routing rules for agents:

1. **One independently useful image** → infer a kind, match a pattern when useful, **compile slots into `--prompt`** (see below), then generate.
2. **Coordinated project** (series, article, full note, deck, campaign, brand, screen flow) → select an internal workflow from `references/workflows/index.tsv`.
3. **Broad or long-tail request** → infer the outcome; never require the user to know a kind, pattern, or command.
4. Direct slashes remain expert shortcuts, not a prerequisite for discovery.
5. **Raw / free-form** only when the user explicitly wants an unstructured prompt.

## Single-image production compile (v0.6.1+)

Do not send a one-line vague prompt when a documented pattern applies. Method:

1. Map intent → `kind` (+ matrix flags for xhs / infographic / cover when useful).
2. Read `references/patterns/index.tsv`, then the matched pattern doc (six deep patterns: `ui-screen-system`, `infographic-explainer`, `poster-layout`, `product-commerce`, `brand-identity`, `document-publishing`).
3. Fill **required slots**. Ask at most 1–3 questions for missing slots that change the result.
4. If visual direction is ambiguous, offer **2–3 short directions**, then compile.
5. Build `--prompt` in the pattern’s **compile order** (task → structure → visual system → short labels → constraints). Full skeleton: `references/patterns/compile-guide.md`.
6. Append pattern **negatives** and **text policy**. For Chinese `xhs` / `xhs-cover` / `wechat`, always apply the **Chinese social text lock** in `document-publishing`.
7. Optional `--dry-run`, then one paid call. Never auto-retry failures; adjust slots and re-confirm.

Kinds inject baseline art direction; the compiled user prompt supplies hierarchy, slots, and locks.

## Agent-led creative projects

Kinds and patterns are internal implementation details. Start from the requested outcome.

1. Decide whether the request is a **single asset** or a **project**.
2. For a project, read `references/workflows/index.tsv`, then only the selected guide and referenced pattern/module files.
3. Infer audience, channel, source facts, deliverables, and visual direction before asking questions. Ask only for missing decisions that materially change the result.
4. Present the content/asset plan and exact image count. Make no paid call before explicit plan approval.
5. Generate exactly one planned anchor, then obtain explicit anchor approval before the remaining batch.
6. Use the approved anchor with `--ref` and a shared style token. Never retry a failed paid request automatically.
7. Deliver reviewable content plus an ordered asset map; regenerate only rejected or failed assets.
8. Each asset may still use single-image slot compile for its own `--prompt`.

Workflow statuses:

| Status | Meaning |
| --- | --- |
| `stable` | Complete intake, approval, production, and deliverable contract |
| `guided` | Usable with documented boundaries; results require closer review |
| `expert-review` | Requires rights, factual, policy, or professional review before batch production |

Validate a saved plan offline before generation:

```bash
python3 <skill-dir>/scripts/validate-workflow-plan --for-anchor asset-plan.json
python3 <skill-dir>/scripts/validate-workflow-plan --for-batch asset-plan.json
```

This validator is the mandatory readiness check for **agent-managed projects**. The low-level CLI intentionally remains a direct single-request primitive; invoking it approves only that one call and does not authorize a project batch.

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
- For multi-asset projects, confirm the bounded plan, generate one anchor, then confirm the anchor before the rest
- Prefer `--dry-run` for request preview (no network)  
- User running the helper counts as approval for that invocation  
- Never commit API keys  
- A paid `generate`/`edits` request is sent once only: the CLI never retries timeouts, `429`, or `5xx` responses automatically
- `--n` accepts only the positive integer `1`; multiple paid results are rejected rather than silently discarded
- Existing output files are refused by default. Pass `--force` explicitly to replace one; successful images are written via a same-directory temporary file and atomic rename
- The CLI requests `b64_json` and refuses URL-only responses instead of fetching a server-provided secondary URL
- Config files may contain keys and must be owner-only (`0600` or stricter); `$TZAI_IMAGE_CONFIG` must point to an existing regular file

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
| **diagram** 结构 | `flowchart` `architecture` `mindmap` `diagram` `infographic` `dataviz` | 流程图、架构图、思维导图、信息图 |
| **product** 产品 | `ui` `wireframe` `empty-state` `onboarding` | 仪表盘、线框、空状态、引导页 |
| **marketing** 市场 | `slide` `banner` `email-header` `cover` `poster` | PPT 封面、投放、邮件头图、文章封面 |
| **social** 社交 | `xhs` `xhs-cover` `wechat` | **小红书图卡/封面**、微信配图 |
| **photo** 影像 | `product-photo` `photo` `landscape` `illustration` `storybook` `food` | 商品图、风光、插画、绘本、美食 |

Agent routing:

1. Map user intent → **kind** (e.g. 小红书 → `xhs`, 流程图 → `flowchart`)  
2. For a **single asset**, compile a **slot-based visual brief** into `--prompt` (kind injects baseline art direction + default `--ar`; pattern supplies structure/negatives)
3. Run generate  

```bash
# Kind API (recommended)
bash <skill-dir>/scripts/tzai-image generate \
  --kind icon --prompt "spark for AI coding app" --image ./icon.png

# Kind as subcommand (scene entry)
bash <skill-dir>/scripts/tzai-image flowchart \
  --prompt "注册 → 激活 → 付费" --image ./flow.png

# Scene matrices (style / layout / cover dimensions)
bash <skill-dir>/scripts/tzai-image presets xhs
bash <skill-dir>/scripts/tzai-image xhs --style notion --layout dense \
  --prompt "三步写好周报" --image ./xhs-card.png
bash <skill-dir>/scripts/tzai-image xhs --preset knowledge-card \
  --prompt "三步写好周报" --image ./xhs-card.png
bash <skill-dir>/scripts/tzai-image infographic --layout funnel --style tech-schematic \
  --prompt "注册转化漏斗" --image ./info.png
bash <skill-dir>/scripts/tzai-image cover --type hero --palette dark --mood bold --text none \
  --prompt "分布式可观测性" --image ./cover.png
```

Workflows (agent multi-image):

| File | Use |
| --- | --- |
| `references/workflows/index.tsv` | Full natural-language workflow router |
| `references/workflows/xhs-note.md` | 完整小红书笔记 + 图卡 |
| `references/workflows/wechat-article.md` | 公众号文章内容包 + 封面 |
| `references/workflows/article-illustrate.md` | 文章章节配图规划与生成 |
| `references/workflows/ui-flow.md` | 单页 / 多页面 UI 设计 |
| `references/workflows/deck-package.md` | 多页 PPT 内容与视觉包 |
| `references/patterns/index.tsv` | Internal visual pattern router |
| `references/workflows/cover-dimensions.md` | 封面五维 |
| `references/workflows/infographic-matrix.md` | 信息图矩阵 |

Reference image (style anchor / series consistency):

```bash
bash <skill-dir>/scripts/tzai-image illustration \
  --ref ./01-cover.png \
  --prompt "同系列第二节配图：…" --image ./02.png
```

(`--ref` uses `/v1/images/edits`; repeatable.)

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
presets xhs|infographic|cover
init --api-key <sk> [...]
doctor [--strict-auth]
which-config | config-path
models
generate --kind <id> --prompt <text> --image <path>
         [--ref <file>]...
         [--style] [--layout] [--palette] [--preset]
         [--type] [--rendering] [--text] [--mood]
         [--ar] [--model] [--n 1] [--force] [--dry-run] [--json]
<kind> --prompt <text> --image <path>   # alias, e.g. icon|flowchart|xhs|infographic
--version
```

Catalog: `references/kinds.tsv` · patterns: `references/patterns/` · compile: `references/patterns/compile-guide.md` · workflows: `references/workflows/` · schemas: `references/schemas/`.

## Troubleshooting

1. `doctor` and fix `[FAIL]` lines  
2. Confirm key at https://tzai.kdp.cool/console  
3. Wrong scene quality → pick a better `--kind` (`kinds` list)  
4. `which-config` to see whether key comes from `env` vs `file`  
