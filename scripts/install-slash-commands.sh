#!/usr/bin/env bash
# Install /tzai-* slash wrappers for multiple agent clients (not only Grok).
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
SRC="${ROOT}/commands"
PRUNE=false

usage() {
  cat <<'EOF'
Usage: bash scripts/install-slash-commands.sh [--prune]

Install /tzai-* command wrappers as symlinks for supported agent clients.

Options:
  --prune  Remove only stale symlinks that point into this repository's
            commands directory. Regular files and external symlinks are kept.
  -h, --help  Show this help message.
EOF
}

while (($#)); do
  case "$1" in
    --prune) PRUNE=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

if [[ ! -d "$SRC" ]] || ! compgen -G "${SRC}/tzai-*.md" >/dev/null; then
  echo "Missing command files. Run: bash scripts/gen-kind-skills.sh" >&2
  exit 1
fi

link_points_into_source() {
  local link="$1" resolved
  resolved="$(python3 - "$link" <<'PY'
import os
import sys
print(os.path.realpath(sys.argv[1]))
PY
)"
  [[ "$resolved" == "$SRC/"* ]]
}

link_commands() {
  local dest="$1"
  mkdir -p "$dest"
  local n=0 skipped=0 pruned=0
  local f target base
  if [[ "$PRUNE" == true ]]; then
    for target in "$dest"/tzai-*.md; do
      [[ -L "$target" ]] || continue
      base="$(basename "$target")"
      if [[ ! -e "${SRC}/${base}" ]] && link_points_into_source "$target"; then
        rm -- "$target"
        pruned=$((pruned + 1))
      fi
    done
  fi
  for f in "$SRC"/tzai-*.md; do
    [[ -f "$f" ]] || continue
    base="$(basename "$f")"
    target="${dest}/${base}"
    if [[ -e "$target" || -L "$target" ]]; then
      if [[ -L "$target" ]] && link_points_into_source "$target"; then
        ln -sfn "$f" "$target"
      else
        echo "  warning: keeping existing ${target}" >&2
        skipped=$((skipped + 1))
        continue
      fi
    else
      ln -s "$f" "$target"
    fi
    n=$((n + 1))
  done
  echo "  commands: ${n} linked, ${skipped} kept → ${dest}"
  if [[ "$PRUNE" == true ]]; then
    echo "  pruned: ${pruned} stale repository symlinks"
  fi
}

echo "== Slash command wrappers (commands/*.md) =="
# Claude Code + Grok + shared agents roots
link_commands "${HOME}/.agents/commands"
link_commands "${HOME}/.grok/commands"
link_commands "${HOME}/.claude/commands"
# Other clients that use commands/ or similar
link_commands "${HOME}/.cursor/commands"
link_commands "${HOME}/.codex/commands"
link_commands "${HOME}/.config/opencode/commands"
link_commands "${HOME}/.opencode/commands"
link_commands "${HOME}/.windsurf/commands"
link_commands "${HOME}/.continue/commands"

# Project-local (if invoked from a project tree)
if git rev-parse --show-toplevel >/dev/null 2>&1; then
  PROJ="$(git rev-parse --show-toplevel)"
  for d in .agents/commands .grok/commands .claude/commands .cursor/commands; do
    mkdir -p "${PROJ}/${d}" 2>/dev/null || true
    if [[ -d "${PROJ}/${d}" ]]; then
      link_commands "${PROJ}/${d}"
    fi
  done
fi

echo
echo "== Skills install (all agents) =="
echo "Run this so every agent gets /tzai-* skills:"
echo
echo "  npx skills add kedoupi/tzai-image-skill -g --all"
echo "  # same as: -g --agent '*' --skill '*' -y"
echo
echo "Supported agents depend on your skills CLI version (claude-code, cursor,"
echo "codex, grok, opencode, windsurf, …). Unsupported agents are skipped."
echo
echo "== API key (shared) =="
echo "  export TZAI_API_KEY='sk-...'"
echo "  # or: bash ~/.agents/skills/tzai-image/scripts/tzai-image init --api-key sk-..."
echo
echo "Plan C: engine + 6 hubs + 11 high-freq kinds (see slash-whitelist.txt)"
echo "Scene catalog: docs/SCENES.md · Capability: docs/architecture/CAPABILITY-ROADMAP.md"
echo "Demos: docs/demos.tsv · regenerate: bash scripts/gen-demos.sh"
echo "Then open any agent and type /  → search tzai-"
