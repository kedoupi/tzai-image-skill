#!/usr/bin/env bash
# Install /tzai-* slash wrappers for multiple agent clients (not only Grok).
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
SRC="${ROOT}/commands"
if [[ ! -d "$SRC" ]] || ! compgen -G "${SRC}/tzai-*.md" >/dev/null; then
  echo "Missing command files. Run: bash scripts/gen-kind-skills.sh" >&2
  exit 1
fi

link_commands() {
  local dest="$1"
  mkdir -p "$dest"
  local n=0
  local f base
  for f in "$SRC"/tzai-*.md; do
    [[ -f "$f" ]] || continue
    base="$(basename "$f")"
    ln -sfn "$f" "${dest}/${base}"
    n=$((n + 1))
  done
  echo "  commands: ${n} → ${dest}"
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
echo "Scene catalog: docs/SCENES.md"
echo "Then open any agent and type /  → search tzai-"
