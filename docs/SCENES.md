# Scene catalog · 场景总表

How **tzai-image** maps workplace / content image jobs — inspired by
[baoyu-skills](https://github.com/JimLiu/baoyu-skills) scene skills, delivered as
**one engine + classified kinds + multi-agent slash commands**.

**能力规划（大众优先 · 借鉴对照）→ [CAPABILITY-ROADMAP.md](./CAPABILITY-ROADMAP.md)**  
**教学画廊（命令 × 示例图）→ [README](../README.md#gallery--learn-by-example)** · demos: [demos.tsv](./demos.tsv)

Default model: **`gpt-image-2`** · Gateway: **https://tzai.kdp.cool**

---

## Plan C slash surface

Not every kind gets a slash. **Whitelist:** `skills/tzai-image/references/slash-whitelist.txt`.

| Layer | Count | Entries |
| --- | --- | --- |
| Engine | 1 | `/tzai-image` |
| Category hubs | 6 | `/tzai-brand` `/tzai-diagram` `/tzai-product` `/tzai-marketing` `/tzai-social` `/tzai-photo` |
| High-freq kinds | 11 | `/tzai-icon` `/tzai-logo` `/tzai-flowchart` `/tzai-architecture` `/tzai-infographic` `/tzai-cover` `/tzai-slide` `/tzai-xhs` `/tzai-xhs-cover` `/tzai-wechat` `/tzai-ui` |
| Long-tail | ~19 kinds | Engine only: `/tzai-image mindmap …` etc. |

---

## Architecture (vs baoyu)

| Layer | baoyu | tzai-image |
| --- | --- | --- |
| Engine | `baoyu-image-gen` (multi-provider) | **`tzai-image`** (TaoziAPI only) |
| Scenes | Separate skills (`baoyu-xhs-images`, `baoyu-infographic`, …) | **kind + Plan C slash** (hubs + high-freq only) |
| Install | Many packages | **One repo** `npx skills add kedoupi/tzai-image-skill -g --all` |
| Slash | One per skill | **~18 slashes** (not 30+ thin skills) |

```text
npx skills add → each skills/tzai-*/SKILL.md
                 becomes /tzai-* in Claude / Cursor / Codex / Grok / …

commands/*.md  → optional extra slash wrappers for Grok & Claude commands/
```

---

## Multi-agent install

```bash
# 1) Install ALL scene skills + engine into every supported agent
npx skills add kedoupi/tzai-image-skill -g --all
# equivalent:
# npx skills add kedoupi/tzai-image-skill -g --agent '*' --skill '*' -y

# 2) Link slash wrappers into client command directories (Grok / Claude / agents)
git clone https://github.com/kedoupi/tzai-image-skill.git
cd tzai-image-skill
bash scripts/install-slash-commands.sh
```

| Agent | Skills path (typical) | Slash |
| --- | --- | --- |
| **Grok Build** | `~/.grok/skills/tzai-*` + `~/.agents/skills/tzai-*` | `/tzai-icon` … |
| **Claude Code** | `~/.claude/skills/tzai-*` | `/tzai-icon` … |
| **Codex** | `~/.codex/skills/tzai-*` | skill / slash menu |
| **Cursor** | `~/.cursor/skills/tzai-*` | skill panel |
| **Others** | via `npx skills add --agent '*'` | per client |

API key (all agents share durable config or env):

```bash
export TZAI_API_KEY='sk-...'
# or
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-...
```

---

## Baoyu → tzai scene map

| baoyu skill | What it does | Our slash / kind | Notes |
| --- | --- | --- | --- |
| **baoyu-image-gen** | Multi-provider engine | `/tzai-image` | Engine only; we fix provider=TaoziAPI |
| **baoyu-xhs-images** | 小红书图卡系列 style×layout | `/tzai-xhs` `/tzai-xhs-cover` | Single-card P0; series later |
| **baoyu-infographic** | layout×style 信息图 | `/tzai-infographic` `/tzai-dataviz` | Kind injects infographic direction |
| **baoyu-diagram** | 技术示意图 / 图示 | `/tzai-diagram` `/tzai-flowchart` `/tzai-architecture` `/tzai-mindmap` | Split into work diagram kinds |
| **baoyu-cover-image** | 文章封面 5 维 | `/tzai-cover` `/tzai-poster` | Cover + vertical poster |
| **baoyu-article-illustrator** | 文章配点 + 多图 | `/tzai-illustration` + agent loop | Agent plans spots → multi generate |
| **baoyu-slide-deck** | 幻灯片成套 | `/tzai-slide` | Title/cover visual; multi-page later |
| **baoyu-comic** | 知识漫画 | `/tzai-storybook` / illustration | Panel series P1 |
| **baoyu-post-to-wechat** | 发公众号 | — | Out of scope (publish, not gen) |
| **baoyu-post-to-weibo / x** | 发微博/X | — | Out of scope |
| **baoyu-wechat-summary** | 微信摘要 | `/tzai-wechat` (visual only) | Summary text ≠ image |
| **baoyu-compress-image** | 压图 | — | Out of scope P0 |
| **baoyu-translate / url-to-md / …** | 非生图 | — | Not image |

---

## Full scene list (slash × category)

### 品牌识别 `/tzai-brand`

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-icon` | icon | App 图标 |
| `/tzai-logo` | logo | Logo / monogram |
| `/tzai-moodboard` | moodboard | 品牌情绪板 |
| `/tzai-mascot` | mascot | 吉祥物 |
| `/tzai-badge` | badge | 徽章 / 贴纸 |
| `/tzai-avatar` | avatar | 职业头像 |

### 结构图示 `/tzai-diagram`（≈ baoyu-diagram + infographic）

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-flowchart` | flowchart | 流程图 / 业务流程 |
| `/tzai-architecture` | architecture | 系统架构图 |
| `/tzai-mindmap` | mindmap | 思维导图 |
| `/tzai-diagram` | diagram | 通用技术示意图 |
| `/tzai-infographic` | infographic | 信息图 |
| `/tzai-dataviz` | dataviz | 数据可视化艺术 |

### 产品设计 `/tzai-product`

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-ui` | ui | UI / 仪表盘示意 |
| `/tzai-wireframe` | wireframe | 线框图 |
| `/tzai-empty-state` | empty-state | 空状态插画 |
| `/tzai-onboarding` | onboarding | 引导主视觉 |

### 市场内容 `/tzai-marketing`（≈ cover + deck 向）

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-slide` | slide | PPT 封面底图 |
| `/tzai-banner` | banner | 投放 Banner |
| `/tzai-email-header` | email-header | 邮件头图 |
| `/tzai-cover` | cover | 文章封面 |
| `/tzai-poster` | poster | 竖版海报 |

### 社交种草 `/tzai-social`（≈ baoyu-xhs + 微信配图）

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-xhs` | xhs | 小红书图卡 |
| `/tzai-xhs-cover` | xhs-cover | 小红书封面 |
| `/tzai-wechat` | wechat | 微信公众号配图 |

### 影像插画 `/tzai-photo`

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-product` | product | 商品目录摄影 |
| `/tzai-photo` | photo | 通用摄影 |
| `/tzai-landscape` | landscape | 风光 / 头图 |
| `/tzai-illustration` | illustration | 通用插画 |
| `/tzai-storybook` | storybook | 绘本 / 叙事画 |
| `/tzai-food` | food | 美食 / 生活方式 |

### 引擎

| Slash | Role |
| --- | --- |
| `/tzai-image` | 总入口：`kinds` / `doctor` / 自由 prompt / 任意 kind |

---

## Usage patterns

```text
/tzai-icon AI 编程火花
/tzai-flowchart 注册 → 激活 → 付费
/tzai-architecture 客户端 网关 微服务 DB 队列
/tzai-infographic Q1 增长四要素
/tzai-xhs 三步写好周报
/tzai-diagram          ← 分类入口，再选 flowchart / architecture …
```

CLI equivalent:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon --prompt "..." --image out.png
bash ~/.agents/skills/tzai-image/scripts/tzai-image kinds
```

---

## Roadmap (baoyu parity)

| Feature | Status |
| --- | --- |
| Single-image scene kinds | **Done** |
| Multi-agent skill install | **Done** (`-g --all`) |
| Command wrappers for Grok/Claude | **Done** (`install-slash-commands.sh`) |
| XHS multi-card series (1–10) | P1 |
| Infographic layout×style matrix | P1 |
| Article multi-spot illustrator | P1 |
| Full slide deck batch | P1 |
