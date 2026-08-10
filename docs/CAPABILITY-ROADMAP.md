# tzai-image 能力规划（大众优先 · 借鉴对照）

> 产品名：**tzai-image**（TaoziAPI 生图 skill）  
> 原则：**大众高频场景优先**；baoyu 有则借鉴；baoyu 无则查业界最优实践。  
> 架构不变：**一个引擎 + kind 场景 + 多 Agent 斜杠**（不 fork 成 20 个独立包）。

关联文档：

- 场景总表：[SCENES.md](./SCENES.md)
- 数据源：`skills/tzai-image/references/kinds.tsv`
- 对标上游：[JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills)

---

## 0. 决策框架

| 问题 | 我们的答案 |
| --- | --- |
| 先服务谁？ | **内容创作者 + 职场打工人**（最高频） |
| baoyu 有同场景？ | **借鉴**其 skill 能力模型（style×layout、确认流、prompt 落盘、批量策略） |
| baoyu 无？ | **上网找最优**（营销 skill、Midjourney/Flux 提示词模板、设计规范）后固化进 kind |
| 实现形态？ | 加深 **kind 参数 / 预设矩阵 / Agent 工作流**，仍走 `tzai-image` 引擎 |
| 斜杠面？ | **Plan C**：引擎 + 6 分类 hub + ~11 高频 kind（见 `slash-whitelist.txt`） |
| 明确不做？ | 发公众号/微博/X、压图工具链、网页采集翻译（非生图链路） |

```text
大众需求排序
    ↓
  有 baoyu? ──是──► 拆能力点 → 映射到 kind / CLI 参数 / SKILL 流程
    │
    否
    ↓
  业界最佳实践（prompt 结构、画幅、约束、工作流）
    ↓
  写入 kinds.tsv + thin slash + 可选 references/*.md
```

---

## 1. 大众需求优先级总表

优先级说明：

- **P0**：国内内容/职场几乎每周都要 → 必须做深  
- **P1**：高频但可单图先顶住 → 做深可显著拉开差距  
- **P2**：有价值、低频或 AI 本身弱项 → 保持 kind + 提示词质量  
- **Out**：非生图或超出 TaoziAPI 范围

| 优先级 | 大众场景 | 用户画像 | 我们现状 | 主借鉴源 |
| --- | --- | --- | --- | --- |
| **P0** | 小红书图卡/系列 | 博主、运营 | 单卡 kind ✅ | **baoyu-xhs-images** |
| **P0** | 信息图 / 知识大图 | 运营、知识博主、咨询 | 单 kind ✅ | **baoyu-infographic** |
| **P0** | 文章封面 | 公众号、博客 | kind cover ✅ | **baoyu-cover-image** |
| **P0** | 流程/架构/示意图 | 工程师、PM | 多 kind ✅ | **baoyu-diagram** + 工程图规范 |
| **P1** | 文内多点配图 | 作者 | illustration 单图 | **baoyu-article-illustrator** |
| **P1** | PPT/分享 deck | 职场、分享者 | slide 封面 | **baoyu-slide-deck** |
| **P1** | 公众号/微信配图 | 作者 | wechat kind ✅ | baoyu-wechat 向（视觉部分） |
| **P1** | App 图标 / Logo | 创业、产品 | kind ✅ | **业界**（见 §3） |
| **P1** | UI / 线框 / 空状态 | 产品、设计 | kind ✅ | **baoyu-design** 思路 + SaaS 规范 |
| **P2** | 知识漫画分镜 | 科普 | storybook | **baoyu-comic** |
| **P2** | 商品/美食/风光摄影 | 电商、生活 | photo kinds ✅ | **业界**产品摄影模板 |
| **P2** | 吉祥物/徽章/头像 | 品牌轻量 | kind ✅ | **业界** IP/角色一致性 |
| **Out** | 发号/发微博/发 X | 发布 | — | baoyu-post-*（不借鉴实现） |
| **Out** | 压图/采集/翻译 | 工具 | — | 不做 |

---

## 2. P0 场景：能力拆解（必做深）

### 2.1 小红书图卡系列 · `/tzai-xhs`（+ 系列模式）

| 项 | 内容 |
| --- | --- |
| **大众要什么** | 一篇干货 → **1–10 张**可滑动图卡；吸睛封面 + 统一风格 |
| **我们现状** | `kind=xhs` / `xhs-cover`，单图 art direction，3:4 |
| **baoyu 有？** | ✅ **baoyu-xhs-images** |

**从 baoyu 借鉴（能力点，非代码搬运）：**

| 能力 | baoyu 做法 | tzai 落点 |
| --- | --- | --- |
| 风格维 | 12 style：cute / notion / chalkboard / sketch-notes… | `styles.tsv` + `--style` |
| 布局维 | 8 layout：sparse / dense / list / comparison / flow… | `layouts.tsv` + `--layout` |
| 调色板 | macaron / warm / neon 覆盖 | `--palette` |
| 预设 | preset = style×layout 捷径 | `--preset knowledge-card` 等 |
| 系列拆分 | 内容 → 1–10 卡大纲再出图 | Agent 步骤：outline → N×generate |
| 风格锚 | 第 1 张作 ref，2+ 批处理 | `generate --ref first.png`（若 API 支持）或 prompt 一致性字段 |
| 确认策略 | 默认确认方案，`--yes` 跳过 | SKILL 流程 + CLI flag |
| 禁后修字 | 图内文字错了就重生成，不 PS 遮盖 | SKILL 硬规则 |
| prompt 落盘 | 每张 `prompts/NN-xxx.md` | 可选 `outputs/.../prompts/` |

**P0 最小交付：**

1. CLI：`tzai-image xhs --style notion --layout dense --prompt "..."`  
2. SKILL：多卡时先出大纲再循环 kind=xhs  
3. 文档：风格/布局对照表（中文说明 + 示例 prompt）

**暂不做：** 微信自动发布、卡通引擎切换多厂商。

---

### 2.2 信息图 · `/tzai-infographic`

| 项 | 内容 |
| --- | --- |
| **大众要什么** | 一篇文/一堆要点 → **一张出版级信息图**（结构清晰、可发朋友圈/放 PPT） |
| **我们现状** | 单 prefix art direction，无 layout 选择 |
| **baoyu 有？** | ✅ **baoyu-infographic** |

**从 baoyu 借鉴：**

| 能力 | baoyu | tzai 落点 |
| --- | --- | --- |
| Layout 库 | 约 21 种（bento-grid、funnel、iceberg、journey…） | 先做 **8 个高频** layout 预设 |
| Style 库 | 约 22 种（craft-handmade、corporate-memphis、technical-schematic…） | 先做 **6–8 个高频** style |
| 内容分析 | 读 md → 推荐 layout×style | Agent 步骤：推荐 2–3 组合 → 用户确认 |
| 画幅 | landscape / portrait / square / 自定义 | 已有 `--ar`，补命名预设 |
| 参考图 | ref → direct / style / palette | P1：`--ref` + prompt 融合 |
| 禁后修字 | 同 xhs | SKILL 规则 |

**P0 最小高频 layout（先这 8 个）：**

| layout | 大众场景 |
| --- | --- |
| `steps` / linear | 教程、SOP、时间线 |
| `compare` | A vs B、前后对比 |
| `bento` | 多要点总览（默认） |
| `list` | 清单、Ranking |
| `funnel` | 转化、筛选 |
| `pyramid` | 层级、优先级 |
| `mind` | 中心辐射（可复用 mindmap kind） |
| `metrics` | KPI 卡片墙 |

**P0 style（先 6 个）：**  
`clean-corporate` · `notion-line` · `bold-poster` · `soft-pastel` · `tech-schematic` · `craft`

---

### 2.3 文章封面 · `/tzai-cover`

| 项 | 内容 |
| --- | --- |
| **大众要什么** | 标题一句话 → **可放公号/博客的封面**（留标题区、情绪对、不糊字） |
| **我们现状** | kind=cover，16:9 单一方向 |
| **baoyu 有？** | ✅ **baoyu-cover-image** |

**从 baoyu 借鉴 · 五维模型：**

| 维 | 取值示例 | CLI |
| --- | --- | --- |
| **Type** | hero / conceptual / metaphor / scene / minimal / typography | `--type` |
| **Palette** | warm / cool / dark / pastel / mono / macaron… | `--palette` |
| **Rendering** | flat-vector / painterly / digital / hand-drawn… | `--rendering` |
| **Text** | none / title-only / title-subtitle | `--text`（默认 title-only 区，少写死标题字） |
| **Mood** | subtle / balanced / bold | `--mood` |

**工程经验（baoyu + 业界一致）：**

- 默认 **少在图里硬写长标题**（AI 糊字）；优先「留白 + 用户后期叠字」或极短词  
- 比例：`16:9` 默认，补 `2.35:1`（电影感）、`1:1`  
- 错字策略：重生成，禁止遮盖修补  

---

### 2.4 结构图示 · `/tzai-flowchart` `/tzai-architecture` `/tzai-diagram` …

| 项 | 内容 |
| --- | --- |
| **大众要什么** | 流程、架构、时序、组件关系 **一眼能讲清** |
| **我们现状** | 多 kind 位图出图 ✅ |
| **baoyu 有？** | ✅ **baoyu-diagram**（主路径是 **SVG 精确图**，不是位图） |

**借鉴策略（重要差异）：**

| | baoyu-diagram | tzai |
| --- | --- | --- |
| 输出 | 深色主题 **SVG**，文字清晰 | TaoziAPI **位图**（gpt-image-2） |
| 优势 | 标签可读、可改 | 视觉炫、等距/插画感强 |
| 我们做法 | 借 **结构类型划分** 与 **构图规则** | 不强行 SVG；prompt 强调「少字、大图标、清晰箭头」 |

**从 baoyu 借鉴的「图类型」：**

- flowchart / process  
- architecture / structural  
- sequence / protocol（可新增 kind 或并入 diagram）  
- mind map / timeline  
- illustrative intuition（概念直觉图）

**位图质量约束（业界 + 我们实践）：**

- 白底或浅网格；节点少而大；箭头粗；**避免小字段落**  
- 用户关键名词用短标签；长说明放对话文本  
- architecture 默认 isometric 或分层泳道  

**P0：** 强化现有 kind 的 prefix + SKILL 出图前「结构提纲」步骤。  
**P1（可选分叉）：** 另开 `tzai-diagram-svg` 或文档说明「要精确文字用 Mermaid/手写 SVG」。

---

## 3. P1 场景：baoyu 有则借，无则查最优

### 3.1 文内多点配图 · 借鉴 baoyu-article-illustrator

| 借鉴点 | tzai 做法 |
| --- | --- |
| 分析文章结构 | Agent 读 md → 列出 3–8 个配图锚点 |
| Type × Style × Palette 一致 | 全篇共用一套 style token 写入每次 prompt |
| 批量出图 | 循环 `illustration` / `cover` / `dataviz` |

**交付形态：** 不必新 kind；在 `SKILL.md` 增加「文章配图工作流」+ `/tzai-illustration --series`。

---

### 3.2 幻灯片成套 · 借鉴 baoyu-slide-deck

| 借鉴点 | tzai 做法 |
| --- | --- |
| 先大纲后逐页 | outline.md → N× `slide` |
| 可读分享向（非现场演讲口播稿） | prompt：一页一观点、大标题区、少正文 |
| 统一视觉系统 | 首页定 style，后续 `--ref` 或同 palette |

**与 baoyu 差异：** 我们先做 **视觉页**；完整可编辑 PPTX 可后续接 pptx skill，不塞进 tzai 引擎。

---

### 3.3 App 图标 / Logo · **baoyu 无专用 → 业界最优**

参考来源（公开最佳实践归纳）：

- [marketingskills/image](https://github.com/coreyhaines31/marketingskills)：Logo 应用 AI **仅作概念**，最终建议矢量精修  
- Midjourney / 通用 prompt 结构：`subject + medium + style + lighting + framing + constraints`  
- 图标规范：圆角方、单一隐喻、无杂字、透明/纯色底、store-ready  

**固化到 tzai：**

| kind | 强化点 |
| --- | --- |
| `icon` | 强制：rounded square、flat/vector feel、**no text**、no fake UI chrome、single metaphor |
| `logo` | 分 monogram / wordmark 预设；提示「概念稿，非最终矢量」；负空间充足 |
| CLI | `--variant concept|app-store|favicon`（P1） |

**诚实边界（写进 SKILL）：** AI Logo 不稳定 → 输出「品牌概念探索」，商用建议 Figma 精修。

---

### 3.4 UI / 线框 / 空状态 · baoyu-design 思路 + SaaS 规范

baoyu 主仓无 UI skill；**baoyu-design** 走 HTML 原型。我们位图路径借鉴：

| 场景 | 业界要点 | tzai |
| --- | --- | --- |
| Dashboard UI | 卡片+KPI、光暗模式、无真实 PII | `ui` prefix 已有，补「Figma 质感、留白」 |
| Wireframe | 灰阶、线框、低保真 | `wireframe` 强调 low-fi，禁止写成高保真 UI |
| Empty state | 中心插画 + 大留白给文案 | `empty-state` |
| Onboarding | 主视觉 + headline 留白 | `onboarding` |

可选 P2：文档链到 HTML 原型工具，不重复造 baoyu-design。

---

### 3.5 商品 / 美食 / 风光摄影 · **业界模板**

| kind | 借鉴要点 |
| --- | --- |
| `product` | 柔光棚拍、无缝或生活台面、45°/俯视可选、高细节、电商目录感 |
| `food` | 食欲光、浅景深、蒸汽/质感词、Instagram 质感 |
| `landscape` | 电影感宽画幅、大气透视、黄金时刻可选 |
| `photo` | 通用：subject → lighting → lens → mood |

Prompt 骨架（业界通用，写入 references）：

```text
[Subject], [medium/photoreal], [lighting], [camera/lens], [composition], [mood], [palette],
[constraints: no watermark, no logo unless asked]
```

---

### 3.6 知识漫画 · 借鉴 baoyu-comic（P2 加深）

| 借鉴 | tzai |
| --- | --- |
| 画风 × 语气 | `storybook` + style 枚举 |
| 分镜脚本再出图 | Agent：panel script → N 张 |
| 批量 | 同 xhs 批处理策略 |

---

## 4. 统一能力模型（所有场景共用）

从 baoyu **横切能力**抽一层，避免每个 kind 各写一套：

| 横切能力 | 说明 | 优先级 |
| --- | --- | --- |
| **Style / Layout / Palette 参数** | 先落地在 xhs + infographic + cover | P0 |
| **确认后出图** | 推荐方案 → 用户确认；`--yes` 跳过 | P0（SKILL） |
| **Prompt 落盘** | `outputs/<job>/prompts/*.md` 可复现 | P1 |
| **参考图 --ref** | 风格锚 / 系列一致 | P1（视 TaoziAPI） |
| **批量 / 并行** | 系列图 1 锚 + 2..N | P1 |
| **禁后修图内文字** | 错则重生 | P0 文档规则 |
| **多 Agent 斜杠** | `/tzai-*` 全端 | ✅ 已做 |
| **单引擎 TaoziAPI** | 默认 gpt-image-2 | ✅ 已做 |
| **发布链路** | 不做 | Out |

建议目录演进：

```text
skills/tzai-image/
  references/
    kinds.tsv              # 现有
    styles/                # P0 起
      xhs.tsv
      infographic.tsv
      cover.tsv
    layouts/
      xhs.tsv
      infographic.tsv
    workflows/             # Agent 流程说明
      xhs-series.md
      article-illustrate.md
      slide-deck.md
```

CLI 形态（目标）：

```bash
tzai-image xhs --style notion --layout dense --palette macaron --prompt "..."
tzai-image infographic --layout funnel --style tech-schematic --ar 3:4 --prompt "..."
tzai-image cover --type hero --palette dark --mood bold --text none --prompt "..."
tzai-image series xhs --count 5 --prompt "..."   # 或由 Agent 编排
```

---

## 5. 实施路线图

### Phase A — P0 做深（建议下一迭代）

1. **xhs**：style×layout×palette 子集（style≥6，layout≥5）+ 多卡 Agent 流程  
2. **infographic**：8 layout × 6 style 矩阵 + 推荐话术  
3. **cover**：五维精简版（type/palette/rendering/text/mood）  
4. **diagram 族**：加强 SKILL「先列节点再出图」+ 更新 prefix 少字规则  
5. 文档：本文件 + SCENES 交叉链接；README 中文「大众场景」一节  

### Phase B — P1

1. 文章多点配图工作流  
2. slide 多页大纲工作流  
3. icon/logo variant + 诚实边界文案  
4. `--ref` / prompt 落盘 / `--yes`  

### Phase C — P2

1. comic 分镜  
2. 摄影类 prompt 库细化  
3. 可选 SVG 精确图路径说明或独立小 skill  

### 明确不做

- baoyu-post-to-wechat / weibo / x  
- baoyu-compress-image / url-to-markdown / translate  
- 多云厂商路由（保持 TaoziAPI 单一网关）

---

## 6. 验收标准（每个 P0 场景）

| 标准 | 说明 |
| --- | --- |
| **一句话触发** | 用户说场景名即可命中 slash/kind |
| **参数可预期** | style/layout 有表可查、有默认 |
| **单图可离线测** | `tests/run.sh` dry-run 不调 API |
| **示例可复现** | README 或 docs 有 1 条完整命令 + 截图 |
| **多 Agent** | `-g --all` 后 Grok/Claude 等均有入口 |
| **不承诺矢量终稿** | icon/logo/diagram 文案诚实 |

---

## 7. 一页纸对照：大众 × baoyu × tzai

| 大众场景 | baoyu | tzai 现在 | 下一步 |
| --- | --- | --- | --- |
| 小红书系列图 | xhs-images 深 | 单卡 | **P0 矩阵+系列** |
| 信息图 | infographic 深 | 单卡 | **P0 矩阵** |
| 封面 | cover 五维 | 单卡 | **P0 五维精简** |
| 流程/架构 | diagram SVG | 位图 kinds | **P0 结构规则** |
| 文内配图 | article-illustrator | 单 illustration | P1 工作流 |
| 整套 PPT | slide-deck | slide 封面 | P1 多页 |
| Icon/Logo | 无 | kinds 有 | P1 业界规范 |
| UI/线框 | design 另仓 | kinds 有 | P1 提示词 |
| 商品摄影 | 无 | kinds 有 | P2 模板库 |
| 发布 | post-* | 不做 | — |

---

## 8. Plan C 斜杠（已落地）

| 类型 | 列表 |
| --- | --- |
| Hubs | brand, diagram, product, marketing, social, photo |
| High-freq | icon, logo, flowchart, architecture, infographic, cover, slide, xhs, xhs-cover, wechat, ui |
| 教学 | README 画廊 + `docs/demos.tsv` + `scripts/gen-demos.sh` |

## 9. 修订记录

| 日期 | 说明 |
| --- | --- |
| 2026-08-10 | 初版：大众优先、baoyu 对照、业界补齐、P0–P2 路线 |
| 2026-08-10 | Plan C 斜杠收敛 + README 对照教学画廊 |

维护：改 kinds 或矩阵时同步更新本文件 §1–§2 与 [SCENES.md](./SCENES.md)。
