# tzai-image 能力规划（大众优先）

> 产品名：**tzai-image**（TaoziAPI 生图 skill · kedoupi 开源）  
> 原则：**大众高频场景优先**；场景参数可预期；一引擎多 kind。  
> 架构：**一个引擎 + kind 场景 + Plan C 斜杠**。

关联：

- 场景总表：[SCENES.md](./SCENES.md)
- 数据源：`skills/tzai-image/references/kinds.tsv`
- 矩阵：`skills/tzai-image/references/presets/`

---

## 0. 决策框架

| 问题 | 我们的答案 |
| --- | --- |
| 先服务谁？ | **内容创作者 + 职场打工人** |
| 实现形态？ | kind 参数 / 预设矩阵 / Agent 工作流，仍走 `tzai-image` |
| 斜杠面？ | **Plan C**：引擎 + 6 hub + ~11 高频 kind |
| 明确不做？ | 发公众号/微博/X、压图、网页采集翻译（非生图） |

---

## 1. 大众需求优先级

| 优先级 | 场景 | 斜杠 / kind | 状态 |
| --- | --- | --- | --- |
| **P0** | 小红书图卡/系列 | `/tzai-xhs` · `xhs` | 单图 + style×layout ✅ |
| **P0** | 小红书封面 | `/tzai-xhs-cover` | 信息流封面（非商品图）✅ |
| **P0** | 信息图 | `/tzai-infographic` | layout×style ✅ |
| **P0** | 文章封面 | `/tzai-cover` | 五维参数 ✅ |
| **P0** | 流程/架构图 | flowchart / architecture / … | kinds ✅ |
| **P1** | 文内多点配图 | illustration 工作流 | 待加深 |
| **P1** | PPT 多页 | slide 大纲批处理 | 待加深 |
| **P1** | Icon/Logo 变体 | icon / logo | kinds ✅，变体可选 |
| **P1** | UI / 线框 | ui / wireframe | kinds ✅ |
| **P2** | 绘本/漫画分镜 | storybook | kinds ✅ |
| **P2** | 商品/美食/风光 | product-photo / food / landscape | kinds ✅ |
| **Out** | 发布/压图/采集 | — | 不做 |

---

## 2. 已落地矩阵（v0.5）

```bash
tzai-image presets xhs|infographic|cover
tzai-image xhs --style notion --layout dense --prompt "..."
tzai-image xhs --preset knowledge-card --prompt "..."
tzai-image infographic --layout funnel --style tech-schematic --prompt "..."
tzai-image cover --type hero --palette dark --text none --mood bold --prompt "..."
```

| 场景 | 参数 | 数据 |
| --- | --- | --- |
| 小红书 | style / layout / palette / preset | `presets/xhs-*.tsv` |
| 信息图 | style / layout | `presets/infographic-*.tsv` |
| 封面 | type / palette / rendering / text / mood | `presets/cover-*.tsv` |

工作流说明：`references/workflows/`。

---

## 3. 横切能力

| 能力 | 状态 |
| --- | --- |
| Style / Layout / Palette | ✅ xhs + infographic + cover |
| 确认后出图 / `--yes` | 文档约定；CLI 可后续加 |
| Prompt 落盘 | P1 |
| 参考图 `--ref` | P1（视 API） |
| 多卡系列 | workflow 文档 ✅；批处理 CLI P1 |
| 禁后修图内文字 | 文档规则 ✅ |
| 多 Agent 斜杠 | ✅ |
| 单引擎 TaoziAPI | ✅ |
| 发布链路 | Out |

---

## 4. 实施路线

### Done

- Plan C 斜杠面  
- 教学画廊 + TaoziAPI 实机样张  
- P0 矩阵（xhs / infographic / cover）  
- xhs-cover 信息流封面方向（非商品图）  

### P1

1. 文章多点配图工作流 — **Done (v0.5.3)** `workflows/article-illustrate.md`  
2. slide 多页大纲 — **Done (v0.5.3)** `workflows/slide-deck.md`  
3. `--ref` 参考图 — **Done (v0.5.3)** `/v1/images/edits`  
4. Live smoke `TZAI_LIVE=1` — **Done (v0.5.3)**  
5. icon/logo variant / prompt 落盘 — 可选后续

### P2

1. comic 分镜  
2. 摄影类模板库细化  

### 不做

- 社交平台发布  
- 压图 / URL 转 MD / 翻译工具链  
- 多云厂商路由（保持 TaoziAPI）

---

## 5. 验收标准

| 标准 | 说明 |
| --- | --- |
| 一句话触发 | 场景名命中 slash/kind |
| 参数可预期 | style/layout 有表可查 |
| 离线测 | `tests/run.sh` |
| 示例可复现 | README 命令 + 截图 |
| 多 Agent | `-g --all` |
| 对外叙事 | **自有产品**（README 不挂第三方对标） |

---

## 6. 修订记录

| 日期 | 说明 |
| --- | --- |
| 2026-08-10 | 初版能力规划 |
| 2026-08-10 | Plan C + P0 矩阵 + 教学画廊 |
| 2026-08-10 | 对外文档改为自有产品叙事 |
| 2026-08-10 | v0.5.1 P0 hardening: safe config parse, AR validate, safe --json |
| 2026-08-10 | v0.5.2 product-photo rename+alias, HTTP retry, CI, CHANGELOG |
| 2026-08-10 | v0.5.3 --ref edits, multi-image workflows, TZAI_LIVE smoke |
