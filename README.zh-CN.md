# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

**一个 skill，一条命令，覆盖工作里几乎所有生图场景。**

通过 **TaoziAPI**（[tzai.kdp.cool](https://tzai.kdp.cool)）在编码 Agent 中生成图片，默认 **`gpt-image-2`**（网关当前最强图片模型）。

支持 Claude Code、Codex、Cursor、Grok Build 等，经 [skills CLI](https://skills.sh/) 安装。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-kedoupi%2Ftzai--image--skill-181717?logo=github)](https://github.com/kedoupi/tzai-image-skill)

<p align="center">
  <img src="docs/screenshots/icon-app.png" alt="App 图标" width="140" />
  <img src="docs/screenshots/logo-wordmark.png" alt="Logo" width="220" />
  <img src="docs/screenshots/flowchart-process.png" alt="流程图" width="280" />
</p>

<p align="center">
  <img src="docs/screenshots/ui-dashboard.png" alt="仪表盘 UI" width="320" />
  <img src="docs/screenshots/architecture-isometric.png" alt="架构图" width="320" />
</p>

## 产品模块（分类 × 功能）

对齐 baoyu 的场景 skill（`baoyu-xhs-images` / `baoyu-infographic` / `baoyu-diagram` 等），
我们做成 **一个引擎 + 内置场景 kind**，不必装一堆 skill。

```bash
tzai-image kinds                 # 列出全部分类功能
tzai-image kinds xhs             # 查看某一 kind 详情
tzai-image icon --prompt "..." --image out.png
tzai-image flowchart --prompt "..." --image out.png
tzai-image generate --kind infographic --prompt "..." --image out.png
```

| 模块 | Kind（功能） | 对标场景 |
| --- | --- | --- |
| **brand** 品牌 | `icon` `logo` `moodboard` `mascot` `badge` `avatar` | 图标 / Logo / 吉祥物 / 徽章 / 头像 |
| **diagram** 结构 | `flowchart` `architecture` `mindmap` `diagram` `infographic` `dataviz` | ≈ baoyu-diagram + infographic |
| **product** 产品 | `ui` `wireframe` `empty-state` `onboarding` | 仪表盘 / 线框 / 空状态 / 引导 |
| **marketing** 市场 | `slide` `banner` `email-header` `cover` `poster` | PPT / 投放 / 邮件 / 封面 |
| **social** 社交 | `xhs` `xhs-cover` `wechat` | ≈ **小红书 / 微信**（baoyu-xhs） |
| **photo** 影像 | `product` `photo` `landscape` `illustration` `storybook` `food` | 商品 / 风光 / 插画 / 美食 |

每个 kind 自带 **默认画幅** + **专业美术方向**；你只需写内容主题。

## 为什么一个 skill 就够

团队日常要：**图标、Logo、PPT 底图、流程图、架构图、UI 示意、投放 Banner、空状态插画、头像、吉祥物、小红书图卡**……往往在多个网页工具之间来回切。

`tzai-image` 用 **kind 模块** 收成一条 Agent CLI：

| 以前的痛 | 用 tzai-image |
| --- | --- |
| 5 种图换 5 个网站 | **同一命令**，只改 prompt + 画幅 |
| 模型质量参差 | 默认 **`gpt-image-2`** |
| Key 散落在聊天记录 | **环境变量 / 持久配置**，不进安装包 |
| 难复现 | 任意 Agent / 脚本 / CI 同一路径 |

**本页全部截图均为本 skill 真实生成**（TaoziAPI + `gpt-image-2`）。

### 方向总表（24 个真实案例）

| # | 方向 | 比例 | 样例 |
| --- | --- | --- | --- |
| 1 | App **图标** | 1:1 | [icon-app](#1-app-图标设计) |
| 2 | **Logo** / 标志 | 16:9 | [logo-wordmark](#2-logo--品牌标志) |
| 3 | 品牌 **情绪板** | 16:9 | [brand-moodboard](#3-品牌情绪板) |
| 4 | **流程图** | 16:9 | [flowchart-process](#4-流程图--流程设计) |
| 5 | **架构图** | 16:9 | [architecture-isometric](#5-系统架构图) |
| 6 | **思维导图** | 1:1 | [mindmap-strategy](#6-思维导图) |
| 7 | 工作流 **信息图** | 16:9 | [diagram-flow](#7-工作流信息图) |
| 8 | 数据 **信息图** | 16:9 | [infographic-stats](#8-数据指标信息图) |
| 9 | **UI 仪表盘** | 16:9 | [ui-dashboard](#9-ui-仪表盘示意) |
| 10 | 移动端 **线框图** | 9:16 | [wireframe-mobile](#10-移动端线框图) |
| 11 | **空状态**插画 | 1:1 | [empty-state](#11-空状态插画) |
| 12 | **Onboarding** 主视觉 | 16:9 | [onboarding-hero](#12-onboarding-主视觉) |
| 13 | **PPT** 封面底图 | 16:9 | [slide-cover](#13-演示文稿封面底图) |
| 14 | 投放 **Banner** | 16:9 | [banner-campaign](#14-投放-banner) |
| 15 | **邮件**头图 | 16:9 | [email-header](#15-邮件头图) |
| 16 | 成就 **徽章** | 1:1 | [badge-sticker](#16-徽章--贴纸) |
| 17 | 团队 **头像** | 1:1 | [avatar-professional](#17-职业头像) |
| 18 | 3D **吉祥物** | 1:1 | [3d-mascot](#18-3d-品牌吉祥物) |
| 19 | **数据可视化**艺术 | 16:9 | [data-viz-art](#19-数据可视化艺术) |
| 20 | **商品**目录图 | 1:1 | [product-cube](#20-商品--目录摄影) |
| 21 | 竖版科技 **海报** | 9:16 | [poster-tech](#21-竖版科技海报) |
| 22 | 电影感 **风光** | 16:9 | [landscape-dawn](#22-电影感风光) |
| 23 | **绘本**插画 | 1:1 | [illustration-story](#23-绘本插画) |
| 24 | **美食**生活方式 | 1:1 | [food-macro](#24-美食--生活方式) |

---

## 画廊 — 品牌与视觉识别

### 1. App 图标设计

![App 图标](docs/screenshots/icon-app.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./icon-app.png \
  --prompt "极简 App 图标，圆角方标，扁平矢量，发光火花隐喻，蓝色渐变，iOS 风格，无文字"
```

### 2. Logo / 品牌标志

![Logo](docs/screenshots/logo-wordmark.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./logo.png \
  --prompt "现代科技 Logo 几何 monogram，靛蓝与电光青，扁平矢量，白底，充足留白"
```

### 3. 品牌情绪板

![情绪板](docs/screenshots/brand-moodboard.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./moodboard.png \
  --prompt "品牌情绪板：面料纹理、靛蓝青绿奶油色卡、抽象字体条、桌面生活照片角，设计公司风格"
```

---

## 画廊 — 结构图与工作图（高频）

### 4. 流程图 / 流程设计

![流程图](docs/screenshots/flowchart-process.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./flowchart.png \
  --prompt "专业流程图，从左到右 5 步图标节点与干净箭头，企业蓝，白底，咨询 PPT 风格"
```

### 5. 系统架构图

![架构图](docs/screenshots/architecture-isometric.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./architecture.png \
  --prompt "等距软件架构图：客户端、API 网关、微服务、数据库、消息队列、云区域，灰蓝技术插画"
```

### 6. 思维导图

![思维导图](docs/screenshots/mindmap-strategy.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./mindmap.png \
  --prompt "清晰战略思维导图，中心节点与 6 个粉彩分支，细连接线，白底，工作坊风格"
```

### 7. 工作流信息图

![工作流](docs/screenshots/diagram-flow.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./workflow.png \
  --prompt "扁平信息图：Idea → Scaffold → Generate → Publish，圆角卡片，灰蓝，白底"
```

### 8. 数据指标信息图

![数据信息图](docs/screenshots/infographic-stats.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./stats.png \
  --prompt "商务信息图：四张指标卡与增长柱，青绿石板色，干净企业风，白底"
```

---

## 画廊 — 产品设计

### 9. UI 仪表盘示意

![仪表盘](docs/screenshots/ui-dashboard.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./dashboard.png \
  --prompt "SaaS 分析仪表盘 UI 示意，浅色模式，玻璃卡片，图表与 KPI，现代产品设计，无真实隐私数据"
```

### 10. 移动端线框图

![线框图](docs/screenshots/wireframe-mobile.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 9:16 --image ./wireframe.png \
  --prompt "低保真手机线框：登录/首页/个人，灰块与线条，UX 文档风格，白底"
```

### 11. 空状态插画

![空状态](docs/screenshots/empty-state.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./empty-state.png \
  --prompt "项目管理 App 空状态：空剪贴板与小火箭植物，柔和扁平粉彩，预留文案空白"
```

### 12. Onboarding 主视觉

![Onboarding](docs/screenshots/onboarding-hero.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./onboarding.png \
  --prompt "产品 onboarding 主视觉：团队协作与漂浮 UI 卡片，现代 SaaS 扁平插画，明亮专业"
```

---

## 画廊 — 市场与内容运营

### 13. 演示文稿封面底图

![PPT 封面](docs/screenshots/slide-cover.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./slide.png \
  --prompt "演示文稿标题页底图，抽象几何，深蓝与金色，咨询 deck 质感，左侧留标题区，无文字"
```

### 14. 投放 Banner

![Banner](docs/screenshots/banner-campaign.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./banner.png \
  --prompt "B2B AI 工具上线广告 Banner，斜切构图，深色与青色，抽象 AI 节点，高对比，无品牌字"
```

### 15. 邮件头图

![邮件头图](docs/screenshots/email-header.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./email-header.png \
  --prompt "开发者工具邮件头图，代码括号化作路径，靛蓝紫渐变，现代科技 newsletter，无字"
```

### 16. 徽章 / 贴纸

![徽章](docs/screenshots/badge-sticker.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./badges.png \
  --prompt "2x2 圆形成就徽章：星/火箭/盾/勾，扁平贴纸风，白底，游戏化 UI"
```

### 17. 职业头像

![头像](docs/screenshots/avatar-professional.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./avatar.png \
  --prompt "职业头像插画，友善的产品经理气质，柔和棚光，浅灰底，团队通讯录风格"
```

### 18. 3D 品牌吉祥物

![吉祥物](docs/screenshots/3d-mascot.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./mascot.png \
  --prompt "可爱 3D 粘土风狐狸客服吉祥物戴耳机，柔和棚光，粉彩背景，产品 mascot"
```

### 19. 数据可视化艺术

![数据可视化](docs/screenshots/data-viz-art.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./dataviz.png \
  --prompt "抽象数据可视化艺术：飘带图表与星座点阵，深色背景，青品红点缀"
```

---

## 画廊 — 商品、海报与生活

### 20. 商品 / 目录摄影

![商品](docs/screenshots/product-cube.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./product.png \
  --prompt "亮面红色立方体商品摄影，纯白底，柔和棚灯，电商目录风格"
```

### 21. 竖版科技海报

![海报](docs/screenshots/poster-tech.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 9:16 --image ./poster.png \
  --prompt "竖版科技海报，AI 编程 Agent，深蓝与霓虹青，抽象神经网络，极简 UI 美学"
```

### 22. 电影感风光

![风光](docs/screenshots/landscape-dawn.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 --image ./landscape.png \
  --prompt "电影感日出高山湖泊，晨雾松林剪影，国家地理摄影风格"
```

### 23. 绘本插画

![绘本](docs/screenshots/illustration-story.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./story.png \
  --prompt "童话绘本：小机器人在大蘑菇下读书，柔和水彩粉彩，儿童图画书风格"
```

### 24. 美食 / 生活方式

![美食](docs/screenshots/food-macro.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 --image ./food.png \
  --prompt "美食微距：陶瓷杯拿铁爱心拉花，木桌，清晨窗光，浅景深"
```

---

## 工作向 Prompt 速查

| 任务 | `--ar` | Prompt 要点 |
| --- | --- | --- |
| 图标 | `1:1` | 圆角方、扁平矢量、单一隐喻、无字 |
| Logo | `1:1` / `16:9` | monogram、品牌色、留白、矢量感 |
| 流程 / 组织 | `16:9` | 从左到右步骤、干净箭头、企业色 |
| 架构 | `16:9` | 等距、网关、服务、库、队列 |
| UI 示意 | `16:9` | 深/浅色、卡片图表、勿写真实隐私数据 |
| 线框 | `9:16` | 灰块低保真、文档风 |
| 幻灯 / Banner | `16:9` | 留标题区、高对比、少假字 |
| 空状态 / 引导 | `1:1` / `16:9` | 友好扁平、给文案留白 |

务必写清：**风格 + 光线 + 背景 + 不要什么**（水印、乱码假字）。

---

## 安装

```bash
npx skills add kedoupi/tzai-image-skill -g --all
```

## 如何申请并配置 API Key

本 skill **不内置 Key**。

1. 打开 [https://tzai.kdp.cool/console](https://tzai.kdp.cool/console)
2. 创建 API 令牌
3. 任选配置方式：

```bash
# A) 全局环境变量
export TZAI_API_KEY='sk-xxxxxxxx'

# B) 持久文件（skills update 不冲）
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx

# C) 单次参数
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --api-key sk-xxxxxxxx --prompt "一只猫" --image cat.png
```

切勿提交 Key；不要只写在 skill 包目录里。

## 快速开始

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor
bash ~/.agents/skills/tzai-image/scripts/tzai-image kinds

# 工作：图标 / 流程图 / 架构图
bash ~/.agents/skills/tzai-image/scripts/tzai-image icon \
  --prompt "AI 编程火花" --image ./icon.png
bash ~/.agents/skills/tzai-image/scripts/tzai-image flowchart \
  --prompt "注册 → 激活 → 付费" --image ./flow.png
bash ~/.agents/skills/tzai-image/scripts/tzai-image architecture \
  --prompt "客户端 网关 微服务 DB 队列" --image ./arch.png

# 社交：小红书图卡（对标 baoyu-xhs-images）
bash ~/.agents/skills/tzai-image/scripts/tzai-image xhs \
  --prompt "三步写好周报" --image ./xhs.png

# 信息图（对标 baoyu-infographic）
bash ~/.agents/skills/tzai-image/scripts/tzai-image infographic \
  --prompt "Q1 增长四要素" --image ./info.png
```

默认模型 **`gpt-image-2`**；场景质量靠 `--kind` / 子命令，不必手搓长 prompt。

## 配置

| 变量 | 含义 | 默认 |
| --- | --- | --- |
| `TZAI_API_KEY` | API Key | 真调用必填 |
| `TZAI_BASE_URL` | 网关 | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | 图片模型 | **`gpt-image-2`** |
| `TZAI_DEFAULT_AR` | 画幅 | `1:1` |
| `TZAI_TIMEOUT_SEC` | 超时 | `120` |

**加载顺序（后者覆盖前者）：** `.skill-data` 文件 → **进程环境变量** → `$TZAI_IMAGE_CONFIG` → CLI。

| `--ar` | 适合 |
| --- | --- |
| `1:1` | 图标、头像、商品、贴纸 |
| `16:9` | 图示、幻灯、仪表盘、Banner |
| `9:16` | 手机 UI、Stories、竖海报 |

## CLI

```text
kinds [id]
init / doctor / which-config / models
generate --kind <id> --prompt ... --image out.png [...]
<kind> --prompt ... --image out.png     # icon|flowchart|xhs|infographic|...
```

Kind 目录：`skills/tzai-image/references/kinds.tsv`。

## Agent 建议

1. 缺 Key 先 `doctor`  
2. **意图 → kind**（小红书→`xhs`，流程图→`flowchart`，信息图→`infographic`…）  
3. `--prompt` 只写**内容主题**（美术方向由 kind 注入）  
4. 默认 `gpt-image-2` 生成  
5. 回报路径  

宿主 doodle 可用原生工具；要 **TaoziAPI + 场景质量** 用本 skill。

## 开发

```bash
git clone https://github.com/kedoupi/tzai-image-skill.git
cd tzai-image-skill
bash tests/run.sh
```

## 许可证

[MIT](./LICENSE)

## 链接

- GitHub：https://github.com/kedoupi/tzai-image-skill  
- TaoziAPI：https://tzai.kdp.cool  
- 孵化器：https://github.com/kedoupi/skills  
