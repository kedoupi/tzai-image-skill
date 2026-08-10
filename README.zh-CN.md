# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

通过 **TaoziAPI**（[tzai.kdp.cool](https://tzai.kdp.cool)）在编码 Agent 里生成图片。

默认模型：**`gpt-image-2`**（本网关当前最强图片模型）。  
支持 Claude Code、Codex、Cursor、Grok Build 等，经 [skills CLI](https://skills.sh/) 安装。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-kedoupi%2Ftzai--image--skill-181717?logo=github)](https://github.com/kedoupi/tzai-image-skill)

<p align="center">
  <img src="docs/screenshots/product-cube.png" alt="商品摄影示例" width="280" />
  <img src="docs/screenshots/illustration-story.png" alt="绘本插画示例" width="280" />
</p>

## 能生成什么样的图？

下面样例均由本 skill 真实调用 `gpt-image-2` 生成。可直接复制命令改 prompt 试玩。

### 商品 / 目录图（1:1）

电商主图、包装概念、产品白底图。

![商品立方体](docs/screenshots/product-cube.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./product.png \
  --prompt "纯白无缝背景下的亮面红色立方体商品摄影，柔和棚灯，轻微倒影，电商目录风格"
```

### 风光 / 电影感宽图（16:9）

幻灯片、博客头图、封面横图。

![晨曦风光](docs/screenshots/landscape-dawn.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 \
  --image ./landscape.png \
  --prompt "电影感宽画幅风光：晨雾中的高山湖泊，金色日出，松林剪影，体积光，国家地理摄影风格"
```

### 竖版海报 / 社媒（9:16）

App 宣传、Stories、短视频封面。

![科技海报](docs/screenshots/poster-tech.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 9:16 \
  --image ./poster.png \
  --prompt "竖版科技海报：AI 编程 Agent 主题，深蓝渐变背景，霓虹青色点缀，抽象神经网络电路，简洁现代 UI 美学"
```

### 绘本插画（1:1）

儿童读物、叙事插画、柔和插画风。

![绘本插画](docs/screenshots/illustration-story.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./story.png \
  --prompt "童话绘本插画：小机器人在巨大蘑菇下读书，柔和水彩质感，粉彩配色，儿童图画书风格"
```

### 流程 / 信息图式（16:9）

文档与 PPT 用的流程示意（栅格插画，不是 Mermaid 代码图）。

![流程示意](docs/screenshots/diagram-flow.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 16:9 \
  --image ./flow.png \
  --prompt "扁平信息图：从左到右四步 Idea → Scaffold → Generate → Publish，圆角卡片，灰蓝配色，白底，干净图标"
```

### 美食 / 生活方式（1:1）

内容种草、生活方式摄影。

![拿铁微距](docs/screenshots/food-macro.png)

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --ar 1:1 \
  --image ./food.png \
  --prompt "美食微距：陶瓷杯拿铁与爱心拉花，木桌，清晨窗光，浅景深，食欲感强"
```

### 更多场景提示

| 场景 | 比例 | Prompt 思路 |
| --- | --- | --- |
| App 图标概念 | `1:1` | 圆角方标、扁平矢量、单一隐喻、干净背景 |
| 博客头图 | `16:9` | 编辑部风格、渐变、抽象形、少字或无字 |
| 小红书 / 朋友圈封面 | `1:1` 或 `3:4` | 高对比、生活感、友好插画 |
| 架构示意 | `16:9` | 等距/扁平模块、图标化、少杂字 |
| 角色三视图 | `16:9` | 同一角色正/侧/背、白底 |
| UI 氛围稿 | `16:9` | SaaS 仪表盘 mood，玻璃卡片，避免假乱码字 |

小技巧：写清 **风格**（写真/水彩/扁平/等距）、**光线**、**背景**、**不要什么**（无水印、无乱码假字）。

## 安装

```bash
npx skills add kedoupi/tzai-image-skill -g --all
```

## 如何申请并配置 API Key

本 skill **不会**内置 Key。

1. 打开 [https://tzai.kdp.cool/console](https://tzai.kdp.cool/console)
2. 注册 / 登录，创建 API 令牌
3. 任选一种配置方式：

```bash
# A) 全局环境变量（只设这个即可用）
export TZAI_API_KEY='sk-xxxxxxxx'

# B) 持久配置文件（npx skills update 不会冲掉）
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx

# C) 单次命令
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --api-key sk-xxxxxxxx --prompt "一只猫" --image cat.png
```

不要把 Key 提交到 git，也不要只写在 skill 安装包目录里。

## 快速开始

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor

# 本地预览请求（不联网），默认模型 gpt-image-2
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --dry-run --prompt "红色方块" --image /tmp/cube.png

# 真正出图
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --prompt "白底红色方块商品摄影" \
  --image ./cube.png \
  --ar 1:1
```

可选：列出模型（日常可直接用默认最强模型）：

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image models
```

## 配置说明

| 变量 | 含义 | 默认 |
| --- | --- | --- |
| `TZAI_API_KEY` | API Key | 真调用必填 |
| `TZAI_BASE_URL` | 网关 | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | 图片模型 | **`gpt-image-2`** |
| `TZAI_IMAGE_CONFIG` | 显式 env 文件 | 无 |
| `TZAI_DEFAULT_AR` | 画幅 | `1:1` |
| `TZAI_TIMEOUT_SEC` | 超时秒数 | `120` |

**加载顺序（后者覆盖前者）：** `.skill-data` 等配置文件 → **进程环境变量** → `$TZAI_IMAGE_CONFIG` → CLI。

只 `export TZAI_API_KEY` 也能用；文件与 env 同时存在时 **env 优先**。

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image which-config
```

### 画幅建议

| `--ar` | 常见用途 | 请求 size 映射 |
| --- | --- | --- |
| `1:1` | 商品、头像、方图 | 1024×1024 |
| `16:9` | 风光、幻灯、博客头图 | 1792×1024 |
| `9:16` | Stories、竖海报 | 1024×1792 |
| `4:3` / `3:4` | 传统横/竖构图 | 1536×1152 / 1152×1536 |

网关可能返回略不同的像素边长，文件仍为可用 PNG。

## CLI

```text
init --api-key sk-... [--base-url] [--model] [--target durable|global|local] [--force]
doctor [--strict-auth]
which-config | config-path
models
generate --prompt ... --image out.png [--model] [--size] [--ar] [--api-key] [--dry-run] [--json]
--version
```

## Agent 使用建议

用户要画图 / 生图时：

1. 确认已配置 Key（不确定就 `doctor`）
2. 用户要走 **TaoziAPI** 或需要可复现 CLI 时，用本 skill
3. 按场景选比例（商品 `1:1`、头图 `16:9`、竖版 `9:16`）
4. Prompt 写清主体 + 风格 + 光线 + 背景
5. 执行 `generate` 并回报输出路径

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
