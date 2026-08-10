# Workflow: Article multi-spot illustration

Use when the user wants **multiple illustrations for one article** (配点插图), with a consistent visual system.

## Agent steps

1. **Read** the article (markdown / paste / path).
2. **Outline spots** (3–8 max):
   - section / heading
   - visual purpose (metaphor / diagram / lifestyle / UI)
   - suggested kind: `illustration` | `cover` | `dataviz` | `diagram` | …
   - short subject prompt (Chinese or English)
3. **Pick a shared style token** (one line) e.g.  
   `flat editorial teal-slate, soft paper texture, no watermark`  
   Append this to every generate subject.
4. **Confirm plan** unless user said 直接生成 / `--yes`.
5. **Generate in order**:
   - optional: one `cover` first as style anchor
   - then each spot with the **same** style token (+ `--ref cover.png` if available)
6. **Return** ordered paths + which section each image supports.  
   Do **not** paint over bad text — regenerate.

## CLI sketch

```bash
E=~/.agents/skills/tzai-image/scripts/tzai-image
STYLE="flat editorial teal-slate soft paper, consistent series"

bash $E cover --type conceptual --palette cool --text none \
  --prompt "文章封面：$TITLE。$STYLE" --image ./01-cover.png

bash $E illustration --prompt "第2节配图：$SPOT2。$STYLE" --image ./02.png
# with style anchor (if --ref supported):
# bash $E illustration --ref ./01-cover.png --prompt "…$STYLE" --image ./03.png
```

## Kind pick cheat sheet

| Spot type | Kind |
| --- | --- |
| Hero / 头条 | `cover` |
| 概念隐喻 | `illustration` |
| 流程 | `flowchart` |
| 架构 | `architecture` |
| 数据 | `infographic` / `dataviz` |
| 产品界面 | `ui` |

## Limits

- Prefer **3–6** images per article (cost + consistency).
- Subject stays short; style token carries coherence.
