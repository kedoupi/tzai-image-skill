# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

**一个引擎 · Plan C 斜杠面 · 覆盖大众真正会用的生图场景。**

通过 **TaoziAPI**（[tzai.kdp.cool](https://tzai.kdp.cool)）在各类 Agent 里出图，默认模型 **`gpt-image-2`**。

支持 Claude Code、Codex、Cursor、Grok Build 及 [skills CLI](https://skills.sh/) 下 [70+ Agent](https://github.com/vercel-labs/skills#supported-agents)。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-kedoupi%2Ftzai--image--skill-181717?logo=github&logoColor=white)](https://github.com/kedoupi/tzai-image-skill)

---

## 怎么选命令（30 秒自学）

```text
场景已经很具体？     →  高频斜杠   例如 /tzai-xhs  /tzai-flowchart
只知道大方向？       →  分类 hub   例如 /tzai-brand  /tzai-diagram
长尾 / 任意 kind？   →  引擎       /tzai-image mindmap …
```

| 层级 | 数量 | 用途 |
| --- | --- | --- |
| **引擎** | 1 | `/tzai-image` — 任意 kind、`doctor`、自由生图 |
| **分类 hub** | 6 | 宽需求 → 再选具体 kind |
| **高频 kind** | 11 | 大众刚需一句话直达 |
| **长尾 kind** | ~19 | 仍在 `kinds.tsv`；**无**独立斜杠，走引擎 |

白名单：[`skills/tzai-image/references/slash-whitelist.txt`](./skills/tzai-image/references/slash-whitelist.txt)  
Demo 索引：[`docs/demos.tsv`](./docs/demos.tsv)  
场景总表：[`docs/SCENES.md`](./docs/SCENES.md) · 能力规划：[`docs/CAPABILITY-ROADMAP.md`](./docs/CAPABILITY-ROADMAP.md)

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

### API Key

```bash
export TZAI_API_KEY='sk-xxxxxxxx'
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor
```

在 [控制台](https://tzai.kdp.cool/console) 创建 Key；**不要**提交密钥。

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
| `/tzai-photo` | 影像 | — | product, photo, landscape, illustration, storybook, food |

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
`--prompt` 只写**主题内容**；美术方向由 kind 注入。

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

> **注意：** photo 下的 kind `product` 是**商品摄影**，走 `/tzai-image product` 或 `/tzai-photo`。

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
/tzai-photo product 哑光几何产品棚拍
/tzai-image food 拉花拿铁浅景深
```

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image product \
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

## Prompt 小抄（只写主题）

| 场景 | `--prompt` 写什么 | kind 已处理 |
| --- | --- | --- |
| 图标 | 隐喻 + 产品领域 | 圆角方、扁平、无字 |
| 流程 | 步骤 A → B → C | 箭头、职场清晰 |
| 小红书 | 标题 + 要点 | 3:4 图卡气质 |
| 封面 | 主题 + 情绪 | 标题留白、编辑光线 |
| 架构 | 组件列表 | 等距/分层 |

---

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

| 变量 | 含义 | 默认 |
| --- | --- | --- |
| `TZAI_API_KEY` | API Key | 真调用必填 |
| `TZAI_BASE_URL` | 网关 | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | 图片模型 | **`gpt-image-2`** |
| `TZAI_DEFAULT_AR` | 画幅 | `1:1` |
| `TZAI_TIMEOUT_SEC` | 超时 | `120` |

**加载顺序（后者覆盖）：** `.skill-data` → 进程环境 → `$TZAI_IMAGE_CONFIG` → CLI。

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
3. `--prompt` 只写主题  
4. 默认 `gpt-image-2`  
5. 回报路径  

---

面向编码 Agent 的生图 skill：**TaoziAPI 单引擎 + 场景 kind + Plan C 斜杠**。
