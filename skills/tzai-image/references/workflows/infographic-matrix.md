# Workflow: Infographic layout × style

## Agent flow

1. Read content; pick **layout** by structure (steps / compare / metrics / …).
2. Pick **style** by brand (clean-corporate / tech-schematic / …).
3. Optional: recommend 2–3 combinations before generate.
4. Generate one publication image.

```bash
bash $E infographic --layout funnel --style tech-schematic \
  --prompt "注册漏斗四阶段转化" --image funnel.png
bash $E infographic --layout metrics --style clean-corporate \
  --prompt "Q1 四北极星指标" --image kpi.png
```

List options:

```bash
bash $E presets infographic
```
