# Workflow: Xiaohongshu multi-card series

Use when the user wants **1–10 小红书图卡** with consistent style.

## Steps (agent)

1. Read content (md / paste). Extract title + 3–10 atomic points.
2. Propose plan (confirm unless user said 直接生成 / `--yes`):
   - card count (1–10)
   - `--style` + `--layout` (+ optional `--palette`) or `--preset`
   - which card is cover (`xhs-cover` or `xhs --layout sparse`)
3. Generate **card 1 first** (style anchor).
4. Generate cards 2..N with the **same** style/layout/palette; mention “same series visual system as card 1” in subject if needed.
5. Return ordered paths; do **not** paint over wrong on-image text — regenerate.

## CLI examples

```bash
E=~/.agents/skills/tzai-image/scripts/tzai-image
bash $E xhs --preset knowledge-card --prompt "封面：三步写好周报" --image 01-cover.png
bash $E xhs --style notion --layout dense --prompt "步骤1：列清单 …" --image 02.png
bash $E xhs --style notion --layout dense --prompt "步骤2：写重点 …" --image 03.png
```

## Defaults

| | Default |
| --- | --- |
| style | `cute` if unset |
| layout | `balanced` if unset |
| AR | `3:4` (kind default) |
