# Contributing

Thanks for your interest in improving **tzai-image**.

## Development setup

```bash
git clone https://github.com/kedoupi/tzai-image-skill.git
cd tzai-image-skill
bash tests/run.sh
bash skills/tzai-image/scripts/tzai-image --help
```

## Guidelines

1. Keep `skills/tzai-image/SKILL.md` under ~500 lines.
2. Do not hardcode private credentials. Config is plain `KEY=value` (never arbitrary shell).
3. Scripts must resolve their own directory with `pwd -P` for symlink installs.
4. Keep the default README in **English**; update `README.zh-CN.md` for user-facing changes.
5. Bump `metadata.version` in `skills/tzai-image/SKILL.md` when behavior changes.
6. Keep `--dry-run` offline / side-effect free.
7. After changing `kinds.tsv` or `slash-whitelist.txt`, run:

   ```bash
   bash scripts/gen-kind-skills.sh
   ```

8. Commits: Conventional Commits preferred (`feat:`, `fix:`, `docs:`, `test:`).

## Validation

```bash
bash tests/run.sh

# offline previews
bash skills/tzai-image/scripts/tzai-image generate \
  --dry-run --kind icon --prompt "spark for AI app" --image /tmp/t.png

bash skills/tzai-image/scripts/tzai-image xhs \
  --dry-run --style notion --layout dense --prompt "三步写周报" --image /tmp/x.png

# live (needs key)
export TZAI_API_KEY='sk-...'
bash skills/tzai-image/scripts/tzai-image doctor
```

## Docs map

| File | Role |
| --- | --- |
| `README.md` / `README.zh-CN.md` | Public product + teaching gallery |
| `docs/SCENES.md` | Full scene / slash catalog |
| `docs/CAPABILITY-ROADMAP.md` | Priority roadmap |
| `AGENTS.md` | Agent maintainer SoT |
