# tzai-image

[English](./README.md) | [简体中文](./README.zh-CN.md)

通过 **TaoziAPI**（[tzai.kdp.cool](https://tzai.kdp.cool)）在编码 Agent 里生成图片。

安装：

```bash
npx skills add kedoupi/tzai-image-skill
```

## 如何申请并配置 API Key

本 skill **不会**内置 Key。

1. 打开 [https://tzai.kdp.cool/console](https://tzai.kdp.cool/console)
2. 注册 / 登录，创建 API 令牌
3. 任选一种方式配置：

```bash
# A) 全局环境变量（只设这个即可用，不必 init）
export TZAI_API_KEY='sk-xxxxxxxx'

# B) 持久配置文件（npx skills update 不会冲掉）
bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-xxxxxxxx

# C) 单次命令覆盖
bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --api-key sk-xxxxxxxx --prompt "一只猫" --image cat.png --model 你的模型ID
```

不要把 Key 提交到 git，也不要只写在 skill 安装包目录里。

## 快速开始

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image doctor

# 可选：列出模型。默认已用最强图片模型 gpt-image-2
bash ~/.agents/skills/tzai-image/scripts/tzai-image models

bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --dry-run --prompt "红色方块" --image /tmp/cube.png

bash ~/.agents/skills/tzai-image/scripts/tzai-image generate \
  --prompt "红色方块" --image ./cube.png --ar 1:1
```

## 配置说明

| 变量 | 含义 | 默认 |
| --- | --- | --- |
| `TZAI_API_KEY` | API Key | 真调用必填 |
| `TZAI_BASE_URL` | 网关 | `https://tzai.kdp.cool` |
| `TZAI_IMAGE_MODEL` | 图片模型 | **`gpt-image-2`**（内置最强默认） |
| `TZAI_IMAGE_CONFIG` | 显式 env 文件 | 无 |
| `TZAI_DEFAULT_AR` | 画幅 | `1:1` |
| `TZAI_TIMEOUT_SEC` | 超时秒数 | `120` |

**加载顺序（后者覆盖前者）：** `.skill-data` 等配置文件 → **进程环境变量** → `$TZAI_IMAGE_CONFIG` → CLI。

因此只 `export TZAI_API_KEY` 也能用；文件与 env 同时存在时 **env 优先**。

查看生效配置：

```bash
bash ~/.agents/skills/tzai-image/scripts/tzai-image which-config
```

## 开发

```bash
bash tests/run.sh
```

## 许可证

[MIT](./LICENSE)
