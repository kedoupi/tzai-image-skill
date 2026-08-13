# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

**描述你想完成的结果，Agent 负责理解、策划、确认并生成完整创作资产。**

通过 **TaoziAPI**（[tzai.kdp.cool](https://tzai.kdp.cool)）生成单图，或完成 UI、社媒、出版、品牌、商品、Campaign、知识、PPT、角色、空间与叙事项目。默认模型 **`gpt-image-2`**。

支持 Claude Code、Codex、Cursor、Grok Build 及 [skills CLI](https://skills.sh/) 下 [70+ Agent](https://github.com/vercel-labs/skills#supported-agents)。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![CI](https://github.com/kedoupi/tzai-image-skill/actions/workflows/ci.yml/badge.svg)](https://github.com/kedoupi/tzai-image-skill/actions/workflows/ci.yml)
[![GitHub](https://img.shields.io/badge/GitHub-kedoupi%2Ftzai--image--skill-181717?logo=github&logoColor=white)](https://github.com/kedoupi/tzai-image-skill)

---

## 直接描述最终目标

```text
为我的 App 设计 onboarding 和 Dashboard 流程。
把这篇文章做成完整小红书笔记，包含封面和图卡。
给这篇已写好的公众号成稿做封面和正文配图。
分析每个章节需要什么配图，先给方案，确认后再生成。
为新品牌做一套基础视觉方向。
为新品发布准备一套统一的传播素材。
```

Agent 会在内部选择工作流、Pattern、kind、比例与参考图。多资产项目先确认内容和资产方案，再生成一张视觉锚点；锚点确认后才批量调用付费生图。

| 内部层级 | 数量 | 作用 |
| --- | --- | --- |
| **创作工作流** | 27 | 用户目标、访谈、确认、交付物和边界 |
| **视觉 Pattern** | 22 | 可复用构图与 Prompt 方法 |
| **图片 kind** | 30 | 单张图片的底层渲染能力 |
| **引擎** | 1 | 鉴权、dry-run、生成/编辑请求与安全写入 |

工作流：[`docs/architecture/WORKFLOW-CATALOG.md`](./docs/architecture/WORKFLOW-CATALOG.md) · Pattern：[`docs/architecture/PATTERN-LIBRARY.md`](./docs/architecture/PATTERN-LIBRARY.md) · 架构：[`docs/architecture/CREATIVE-WORKFLOW-ARCHITECTURE.md`](./docs/architecture/CREATIVE-WORKFLOW-ARCHITECTURE.md) · 文档索引：[`docs/README.md`](./docs/README.md)

## Agent 工作流示例

| 用户这样说 | Agent 会怎么做 | 最终交付 |
| --- | --- | --- |
| “为这个 SaaS 设计 onboarding 和 Dashboard。” | 推断用户与核心任务，先给页面地图，再生成一个主页面锚点，确认后完成其余页面 | 页面地图、UI 文案、1-8 张统一界面图 |
| “把这篇文章做成完整小红书笔记。” | 改写内容、设计卡片 Storyboard、确认方案，再确认一张封面后生成系列图卡 | `note.md`、封面、顺序图卡、资产映射 |
| “给这篇已有公众号成稿做封面和配图。” | 读取已定稿（或 `wechat-mp-out/<slug>/`），确认视觉地图，再生成头图与已批准插图 | `cover.png`、可选配图、插入位置（不改写 `article.md`） |
| “逐章分析需要什么配图，先让我确认。” | 使用真实章节标题，只推荐有信息价值的图片，确认前不付费生图 | 配图方案、图片、Caption、Alt text |
| “给新品牌做一套基础视觉。” | 理解定位与授权，提供视觉方向，再以选中方向作为系列锚点 | Moodboard、标志概念、Icon 方向、触点说明 |
| “为新品发布准备完整视觉素材。” | 按渠道规划资产，把真实卖点与价格保留在外部文案层 | 商品 Hero、Campaign 衍生图、用途映射、安全文案区 |

### 示例：文章转完整小红书笔记

```text
用户
把这篇文章改成面向产品经理的小红书笔记，专业但要实用。
需要一张封面和五张内容图卡。

Agent — 方案确认
建议制作 6 张图：
01 封面：“AI Agent 落地指南”
02 为什么普通聊天还不是 Agent
03 目标 → 计划 → 工具 → 结果
04 三个产品设计决策
05 常见失败方式
06 收藏清单与 CTA

视觉系统：珊瑚红 + 深海军蓝，移动端强层级，只使用短标签。
付费范围：6 张图。你确认方案后，我只先生成封面。

用户
确认方案。

Agent — 首图确认
已生成 assets/01-cover.png。请确认构图与视觉风格；
确认后才会将它作为 --ref，继续生成 02-06。
```

最终交付是可审核、可恢复的内容包：

```text
xhs-ai-agent-guide/
  brief.json
  plan.md
  note.md
  asset-plan.json
  deliverables.json
  assets/
    01-cover.png
    02-why-agent.png
    03-agent-loop.png
    04-product-decisions.png
    05-failure-modes.png
    06-checklist.png
```

<p align="center">
  <img src="docs/screenshots/xhs-cover.png" alt="小红书封面示例" width="210" />
  <img src="docs/screenshots/xhs-card.png" alt="小红书图卡示例" width="210" />
  <img src="docs/screenshots/ui-dashboard.png" alt="UI Dashboard 示例" width="360" />
</p>

单图请求仍然保持轻量：需求明确时可直接生成。只有完整项目才执行方案与首图两次确认，避免 Agent 静默扩大付费调用。

<p align="center">
  <img src="docs/screenshots/icon-app.png" alt="icon" width="120" />
  <img src="docs/screenshots/architecture-isometric.png" alt="architecture" width="260" />
  <img src="docs/screenshots/xhs-card.png" alt="xhs" width="140" />
</p>

> **样张标准**：画廊应对齐「设计工作室终稿 / 咨询幻灯 / 商业摄影」观感，而不是玩具风示意。  
> 主题尽量具体、有场景与材质；少写废话式「画个好看的图」。重刷：`bash scripts/gen-demos.sh --force`（需 Key）。

---

## 安装

```bash
npx skills add kedoupi/tzai-image-skill -g --all

git clone https://github.com/kedoupi/tzai-image-skill.git && cd tzai-image-skill
bash scripts/install-slash-commands.sh
```

### 安装后（复制粘贴）

**安装 ≠ 配置。** 真正生图前才需要 Key；规划 / dry-run 可不配。

```bash
E=~/.agents/skills/tzai-image/scripts/tzai-image

bash $E doctor   # 缺 Key 时会打印可复制 setup

# 推荐：写 durable 文件（update 不会冲掉；不要写进 ~/.zshrc）
bash $E init --api-key 'sk-YOUR_TOKEN'
# → ~/.config/kedoupi/tzai-image/config.env  (chmod 600)

bash $E which-config
bash $E doctor
```

1. 在 [控制台](https://tzai.kdp.cool/console) 创建 Key  
2. 优先 **`init` 写文件**；`export TZAI_API_KEY=…` 仅适合 CI  
3. **不要**提交密钥，也不要只写在 skill 包目录里
### CLI 速查

```bash
E=~/.agents/skills/tzai-image/scripts/tzai-image
bash $E kinds
bash $E icon --prompt "AI 编程 App 火花图标" --image ./icon.png
bash $E xhs --prompt "三步写好周报" --image ./xhs.png
bash $E mindmap --prompt "产品战略拆解" --image ./mm.png   # 长尾
```

---

## Plan C 斜杠一览

### 引擎

| 斜杠 | 作用 |
| --- | --- |
| **`/tzai-image`** | 总入口：任意 kind、doctor、自由 prompt |

### 分类 hub（6）

| 斜杠 | 领域 | 高频子命令 | 长尾（hub/引擎） |
| --- | --- | --- | --- |
| `/tzai-brand` | 品牌 | icon, logo | moodboard, mascot, badge, avatar |
| `/tzai-diagram` | 结构图示 | flowchart, architecture, infographic | mindmap, diagram, dataviz |
| `/tzai-product` | 产品设计 | ui | wireframe, empty-state, onboarding |
| `/tzai-marketing` | 市场 | cover, slide | banner, email-header, poster |
| `/tzai-social` | 社交 | xhs, xhs-cover, wechat | — |
| `/tzai-photo` | 影像 | — | product-photo, photo, landscape, illustration, storybook, food |

### 高频 kind（11）

| 斜杠 | kind | 比例 | 突出能力 |
| --- | --- | --- | --- |
| `/tzai-icon` | icon | 1:1 | App 图标、单隐喻、无字 |
| `/tzai-logo` | logo | 16:9 | 标志/monogram 概念 |
| `/tzai-flowchart` | flowchart | 16:9 | 流程步骤、咨询清晰度 |
| `/tzai-architecture` | architecture | 16:9 | 系统分层 / 等距 |
| `/tzai-infographic` | infographic | 16:9 | 信息层级、指标卡 |
| `/tzai-cover` | cover | 16:9 | 文章封面 + 标题留白 |
| `/tzai-slide` | slide | 16:9 | PPT 开场底图 |
| `/tzai-xhs` | xhs | 3:4 | 小红书知识卡 |
| `/tzai-xhs-cover` | xhs-cover | 3:4 | 信息流封面 |
| `/tzai-wechat` | wechat | 16:9 | 公众号配图 |
| `/tzai-ui` | ui | 16:9 | SaaS 仪表盘示意 |

---

# 画廊 · 对照教学

每个区块：**什么时候用** → **这一层突出什么** → **斜杠 + CLI** → **效果图**。  
kind 已注入基础美术方向。人手直接调 CLI 时，`--prompt` 写主题和必填标签即可。Agent 应按 `references/patterns/compile-guide.md` 编译槽位，不要只丢一句主题（用户明确要求 raw 除外）。多图项目走工作流 + Pattern。

重新生成截图（需 Key）：

```bash
bash scripts/gen-demos.sh
bash scripts/gen-demos.sh --force
bash scripts/gen-demos.sh --only xhs cover wechat
```

---

## A. 引擎 — `/tzai-image`

**何时用：** 自由发挥、长尾 kind、或「随便画一下」。  
**突出：** 一个 CLI 覆盖全部 kind；`kinds` / `doctor`。

```text
/tzai-image icon 火花隐喻，AI 编程 App
/tzai-image mindmap 产品战略拆解
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon \
  --prompt "AI coding IDE：电蓝火花与抽象代码括号融为一体，玻璃高光，无文字" \
  --image ./icon-app.png
```

![引擎示例](docs/screenshots/icon-app.png)

---

## B. 分类 hub

### `/tzai-brand` · 品牌识别

**何时用：** 「做点品牌图」，还没想好 icon 还是 logo。  
**突出：** 品牌资产路由；高频 **icon/logo** 另有直达斜杠。

```text
/tzai-brand icon 火花与代码感 App 图标
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon \
  --prompt "品牌识别：火花与代码感 App 图标概念" --image ./icon-app.png
```

![品牌 hub](docs/screenshots/icon-app.png)

长尾：`moodboard` `mascot` `badge` `avatar` → `/tzai-image mascot …`

---

### `/tzai-diagram` · 结构图示

**何时用：** 「画个结构/流程/信息图」。  
**突出：** 职场图示 + 信息图族。

```text
/tzai-diagram architecture 客户端 网关 微服务 DB 队列
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image architecture \
  --prompt "客户端 / 网关 / 微服务 / DB / 队列，等距技术风" --image ./arch.png
```

![结构 hub](docs/screenshots/architecture-isometric.png)

---

### `/tzai-product` · 产品设计

**何时用：** 产品演示、空状态、线框（**不是**商品摄影）。  
**突出：** UX 视觉；直达 **`/tzai-ui`**。

```text
/tzai-product ui SaaS 数据分析仪表盘
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image ui \
  --prompt "SaaS 数据分析仪表盘，卡片 KPI 图表，浅色模式" --image ./ui.png
```

![产品 hub](docs/screenshots/ui-dashboard.png)

> **注意：** 商品摄影 kind 是 **`product-photo`**（别名 `product`），不是本 hub。走 `/tzai-image product-photo` 或 hub `/tzai-photo`。

---

### `/tzai-marketing` · 市场内容

**何时用：** 封面、PPT、投放。  
**突出：** 直达 **`/tzai-cover`** **`/tzai-slide`**。

```text
/tzai-marketing slide 咨询风分享会开场底图
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image slide \
  --prompt "分享会开场页底图，咨询几何，中部留标题区" --image ./slide.png
```

![市场 hub](docs/screenshots/slide-cover.png)

---

### `/tzai-social` · 社交种草

**何时用：** 小红书 / 微信。  
**突出：** 三个社交 kind 都是高频斜杠。

```text
/tzai-social xhs 三步写好周报
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image xhs \
  --prompt "三步写好周报：列清单 写重点 加复盘" --image ./xhs.png
```

![社交 hub](docs/screenshots/xhs-card.png)

---

### `/tzai-photo` · 影像插画

**何时用：** 商品、风光、美食、绘本等**长尾**影像。  
**突出：** 本类无高频 kind 斜杠，一律 hub 或引擎。

```text
/tzai-photo product-photo 哑光几何产品棚拍
/tzai-image food 拉花拿铁浅景深
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image product-photo \
  --prompt "哑光几何体商品，柔光棚拍，目录级质感" --image ./product.png
```

![影像 hub](docs/screenshots/product-cube.png)

---

## C. 高频 kind 命令

### `/tzai-icon` · App 图标

**突出：** 圆角方、扁平矢量、**单一隐喻**、**无字**。

```text
/tzai-icon 发光火花，AI 编程 App
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon \
  --prompt "AI coding IDE：电蓝火花与代码括号融合，iOS 级玻璃高光，无任何文字" \
  --image ./icon-app.png
```

![icon](docs/screenshots/icon-app.png)

---

### `/tzai-logo` · Logo

**突出：** 几何标志、负空间；AI 输出当**概念稿**，非最终矢量。

```text
/tzai-logo 几何 N，靛蓝与电青绿
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image logo \
  --prompt "科技 monogram「N」：靛蓝×电青绿几何切角，超大负空间，白底品牌规范稿" \
  --image ./logo.png
```

![logo](docs/screenshots/logo-wordmark.png)

---

### `/tzai-flowchart` · 流程图

**突出：** 从左到右步骤、清晰箭头、职场可读。

```text
/tzai-flowchart 注册 → 激活 → 付费
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image flowchart \
  --prompt "B2B 漏斗五步：获客→激活→养成→付费→扩张，咨询幻灯片清晰度" \
  --image ./flow.png
```

![flowchart](docs/screenshots/flowchart-process.png)

---

### `/tzai-architecture` · 架构图

**突出：** 客户端/网关/服务/库/队列；等距或分层。

```text
/tzai-architecture 客户端 网关 微服务 DB 队列
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image architecture \
  --prompt "云原生观测平台等距全景：探针、Collector、网关、流处理、时序库、告警" \
  --image ./arch.png
```

![architecture](docs/screenshots/architecture-isometric.png)

---

### `/tzai-infographic` · 信息图

**突出：** 层级、指标卡、出版级版式。

```text
/tzai-infographic Q1 增长四要素：获客 激活 留存 变现
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image infographic \
  --layout metrics --style clean-corporate \
  --prompt "年度增长四象限：获客/激活/留存/变现 KPI + sparklines，出版级网格" \
  --image ./info.png
```

![infographic](docs/screenshots/infographic-stats.png)

---

### `/tzai-cover` · 文章封面

**突出：** 情绪 + **标题安全区**（长标题建议后期叠字）。

```text
/tzai-cover 技术博客封面，深色代码光轨，标题留白
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image cover \
  --type hero --palette dark --mood bold --text none \
  --prompt "深度技术封面：暗夜紫黑、精密光轨与玻璃层，下三分之一标题安全区" \
  --image ./cover.png
```

![cover](docs/screenshots/cover-article.png)

---

### `/tzai-slide` · PPT 封面

**突出：** 咨询几何、标题留白、少正文。

```text
/tzai-slide 分享会开场底图
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image slide \
  --prompt "全球战略峰会 title slide：深海军蓝切面、细金线、中央巨大标题留白" \
  --image ./slide.png
```

![slide](docs/screenshots/slide-cover.png)

---

### `/tzai-xhs` · 小红书图卡

**突出：** 3:4 知识卡、强层级、信息流友好。

```text
/tzai-xhs 三步写好周报
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image xhs \
  --preset knowledge-card \
  --prompt "《周报写作三步法》：收集素材 / 提炼亮点 / 结构润色，杂志级排版" \
  --image ./xhs.png
```

![xhs](docs/screenshots/xhs-card.png)

---

### `/tzai-xhs-cover` · 小红书封面

**突出：** 信息流**封面排版**（大标题 + 副标题带），不是商品主图/棚拍。

```text
/tzai-xhs-cover 周报模板 职场干货封面
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image xhs-cover \
  --style bold --layout sparse \
  --prompt "信息流封面（非商品图）：大标题「周报模板」+ 副标题「职场干货·效率翻倍」，杂志封面式色块" \
  --image ./xhs-cover.png
```

![xhs-cover](docs/screenshots/xhs-cover.png)

---

### `/tzai-wechat` · 微信配图

**突出：** 公号头图/文内插图气质，柔和专业。

```text
/tzai-wechat 远程协作与灵感火花
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image wechat \
  --prompt "公号头图：远程会议浮层 + 灵感灯泡，柔和青蓝出版级插画" \
  --image ./wechat.png
```

![wechat](docs/screenshots/wechat-visual.png)

---

### `/tzai-ui` · UI 仪表盘

**突出：** SaaS 卡片/KPI/图表；勿写真实隐私数据。

```text
/tzai-ui 数据分析仪表盘浅色模式
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image ui \
  --prompt "企业级 Revenue OS：ARR KPI、多序列增长曲线、漏斗与侧栏，Linear/Stripe 质感" \
  --image ./ui.png
```

![ui](docs/screenshots/ui-dashboard.png)

---

## D. 长尾示例（仅引擎）

没有 `/tzai-mindmap` 这类斜杠——用引擎或分类 hub。

| 需求 | 用法 |
| --- | --- |
| 思维导图 | `/tzai-image mindmap …` 或 `/tzai-diagram` |
| 线框图 | `/tzai-image wireframe …` |
| 吉祥物 | `/tzai-image mascot …` |
| 美食 | `/tzai-image food …` |
| Banner | `/tzai-image banner …` |

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image mindmap \
  --prompt "策略拆解中心节点，六条分支" --image ./mindmap.png
```

![mindmap](docs/screenshots/mindmap-strategy.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image wireframe \
  --prompt "移动端低保真线框多屏" --image ./wire.png
```

![wireframe](docs/screenshots/wireframe-mobile.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image food \
  --prompt "拉花拿铁，木桌，晨光浅景深" --image ./food.png
```

![food](docs/screenshots/food-macro.png)

更多长尾样张：

| kind | 样张 |
| --- | --- |
| moodboard | ![mood](docs/screenshots/brand-moodboard.png) |
| empty-state | ![empty](docs/screenshots/empty-state.png) |
| onboarding | ![onb](docs/screenshots/onboarding-hero.png) |
| banner | ![banner](docs/screenshots/banner-campaign.png) |
| poster | ![poster](docs/screenshots/poster-tech.png) |
| mascot | ![mascot](docs/screenshots/3d-mascot.png) |
| landscape | ![land](docs/screenshots/landscape-dawn.png) |

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image kinds
```

---

## 单图 Prompt 小抄

| 场景 | `--prompt` 写什么 | kind 已处理 |
| --- | --- | --- |
| 图标 | 隐喻 + 产品领域 | 圆角方、扁平、无字 |
| 流程 | 步骤 A → B → C | 箭头、职场清晰 |
| 小红书 | 标题 + 要点 | 3:4 图卡气质 |
| 封面 | 主题 + 情绪 | 标题留白、编辑光线 |
| 架构 | 组件列表 | 等距/分层 |

---

## 多图工作流（Agent）

| 场景 | 说明 |
| --- | --- |
| 完整工作流路由 | `skills/tzai-image/references/workflows/index.tsv` |
| 完整小红书笔记 | `…/workflows/xhs-note.md` |
| 已有公众号成稿的配图 | `…/workflows/wechat-article.md` |
| 文章章节配图 | `…/workflows/article-illustrate.md` |
| 单页 / 多页面 UI | `…/workflows/ui-flow.md` |
| PPT 内容与视觉包 | `…/workflows/deck-package.md` |

离线校验已保存的资产计划：

```bash
python3 skills/tzai-image/scripts/validate-workflow-plan --for-anchor asset-plan.json
python3 skills/tzai-image/scripts/validate-workflow-plan --for-batch asset-plan.json
```

参考图锚定（系列一致，走 `/v1/images/edits`）：

```bash
bash $E cover --prompt "系列封面…" --image 01.png
bash $E illustration --ref ./01.png --prompt "第二节配图，保持同一视觉系统" --image 02.png
```

## 场景矩阵（style × layout × 封面维度）

先看有哪些选项：

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image presets xhs
bash ~/.agents/skills/tzai-image/scripts/tzai-image presets infographic
bash ~/.agents/skills/tzai-image/scripts/tzai-image presets cover
```

### 小红书 `style × layout × palette`

| 参数 | 示例 | 作用 |
| --- | --- | --- |
| `--style` | `cute` `notion` `bold` `study-notes` … | 视觉气质 |
| `--layout` | `sparse` `dense` `list` `comparison` `flow` | 信息密度/结构 |
| `--palette` | `macaron` `warm` `neon` | 可选调色板覆盖 |
| `--preset` | `knowledge-card` `checklist` `tutorial` … | style+layout 捷径 |

```bash
# 知识干货卡
bash $E xhs --preset knowledge-card --prompt "三步写好周报" --image xhs.png
# 等价
bash $E xhs --style notion --layout dense --prompt "三步写好周报" --image xhs.png
```

多卡系列流程：`skills/tzai-image/references/workflows/xhs-series.md`

### 信息图 `layout × style`

```bash
bash $E infographic --layout funnel --style tech-schematic \
  --prompt "注册漏斗四阶段" --image funnel.png
bash $E infographic --layout metrics --style clean-corporate \
  --prompt "Q1 四北极星指标" --image kpi.png
```

| layout | 适合 | style | 适合 |
| --- | --- | --- | --- |
| `steps` | 教程时间线 | `clean-corporate` | 商务 |
| `compare` | A vs B | `tech-schematic` | 技术文档 |
| `funnel` | 转化 | `notion-line` | 知性线稿 |
| `metrics` | KPI 墙 | `bold-poster` | 强冲击 |
| `bento` | 多要点总览 | `soft-pastel` / `craft` | 柔和/纸艺 |

### 封面五维

```bash
bash $E cover --type hero --palette dark --rendering digital \
  --text none --mood bold --prompt "分布式可观测性" --image cover.png
```

| 维 | 参数 | 常用值 |
| --- | --- | --- |
| Type | `--type` | hero / conceptual / minimal / scene |
| Palette | `--palette` | cool / dark / warm / pastel |
| Rendering | `--rendering` | digital / flat-vector / painterly |
| Text | `--text` | **none** / title-only（少写死长标题） |
| Mood | `--mood` | subtle / balanced / bold |

---

## 配置

推荐路径（`init` 默认）：

```text
~/.config/kedoupi/tzai-image/config.env
```

| 变量 | 含义 | 默认 |
| --- | --- | --- |
| `TZAI_API_KEY` | API Key | 真调用必填 |
| `TZAI_BASE_URL` | 网关 | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | 图片模型 | **`gpt-image-2`** |
| `TZAI_DEFAULT_AR` | 画幅 | `1:1` |
| `TZAI_TIMEOUT_SEC` | 超时（单次生图） | `600` |
| `TZAI_IMAGE_CONFIG` | 显式 env 文件 | 空 |

**加载顺序（文件后覆盖前，再环境变量 / CLI）：**  
旧版 `~/.config/tzai-image/` 与 `.skill-data/` → **`~/.config/kedoupi/tzai-image/config.env`** → `config.local.env` → `$TZAI_IMAGE_CONFIG` → 环境变量 / CLI。

## 维护

```bash
bash scripts/gen-kind-skills.sh
bash scripts/install-slash-commands.sh
bash scripts/gen-demos.sh
bash tests/run.sh
```

## Agent 建议

1. 缺 Key 先 `doctor`  
2. 高频 → 直达斜杠；宽需求 → hub；其余 → 引擎 + `kinds`  
3. `--prompt` 按 compile-guide 编译槽位（人手 CLI 可只写主题）  
4. 默认 `gpt-image-2`  
5. 回报路径  

---

面向编码 Agent 的生图 skill：**TaoziAPI 单引擎 + 场景 kind + Plan C 斜杠**。
