# Scene catalog · 场景总表

**tzai-image** 的职场 / 内容生图场景目录：  
**一个 TaoziAPI 引擎 + 分类 kind + 多 Agent 斜杠（Plan C）**。

**能力规划 → [CAPABILITY-ROADMAP.md](./CAPABILITY-ROADMAP.md)**  
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

```text
npx skills add → each skills/tzai-*/SKILL.md
                 becomes /tzai-* in Claude / Cursor / Codex / Grok / …

commands/*.md  → optional extra slash wrappers for client commands/
```

---

## Multi-agent install

```bash
# 1) Install engine + Plan C skills into supported agents
npx skills add kedoupi/tzai-image-skill -g --all

# 2) Link slash wrappers into client command directories
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

API key (shared durable config or env):

```bash
export TZAI_API_KEY='sk-...'
# or
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-...
```

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

### 结构图示 `/tzai-diagram`

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

### 市场内容 `/tzai-marketing`

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-slide` | slide | PPT 封面底图 |
| `/tzai-banner` | banner | 投放 Banner |
| `/tzai-email-header` | email-header | 邮件头图 |
| `/tzai-cover` | cover | 文章封面 |
| `/tzai-poster` | poster | 竖版海报 |

### 社交种草 `/tzai-social`

| Slash | Kind | Use |
| --- | --- | --- |
| `/tzai-xhs` | xhs | 小红书图卡 |
| `/tzai-xhs-cover` | xhs-cover | 小红书封面 |
| `/tzai-wechat` | wechat | 微信公众号配图 |

### 影像插画 `/tzai-photo`

| Slash | Kind | Use |
| --- | --- | --- |
| — | product-photo | 商品目录摄影（`/tzai-image product-photo`；别名 `product`） |
| — | photo | 通用摄影 |
| — | landscape | 风光 / 头图 |
| — | illustration | 通用插画 |
| — | storybook | 绘本 / 叙事画 |
| — | food | 美食 / 生活方式 |

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
/tzai-xhs-cover 周报模板封面
/tzai-diagram          ← 分类入口，再选 flowchart / architecture …
```

CLI:

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon --prompt "..." --image out.png
bash ~/.agents/skills/tzai-image/scripts/tzai-image kinds
bash ~/.agents/skills/tzai-image/scripts/tzai-image presets xhs
```

---

## Roadmap

| Feature | Status |
| --- | --- |
| Single-image scene kinds | **Done** |
| Multi-agent skill install | **Done** (`-g --all`) |
| Plan C slash surface | **Done** |
| XHS / infographic / cover matrices | **Done** (v0.5) |
| XHS multi-card series (1–10) | P1 |
| Article multi-spot illustrator | P1 |
| Full slide deck batch | P1 |
