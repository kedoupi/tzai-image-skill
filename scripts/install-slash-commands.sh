#!/usr/bin/env bash
# Install /tzai-* slash command wrappers into agent command directories.
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
SRC="${ROOT}/commands"
if [[ ! -d "$SRC" ]]; then
  echo "Missing $SRC — run scripts/gen-kind-skills.sh first" >&2
  exit 1
fi

install_dir() {
  local dest="$1"
  mkdir -p "$dest"
  local n=0
  for f in "$SRC"/*.md; do
    [[ -f "$f" ]] || continue
    base="$(basename "$f")"
    ln -sfn "$f" "${dest}/${base}"
    n=$((n + 1))
  done
  echo "  linked ${n} commands → ${dest}"
}

echo "Installing tzai-image slash commands from ${SRC}"
install_dir "${HOME}/.grok/commands"
install_dir "${HOME}/.claude/commands"
install_dir "${HOME}/.agents/commands"

# Optional project-local (run from a project if desired)
if [[ -d "${PWD}/.grok" ]] || [[ -d "${PWD}/.git" ]]; then
  mkdir -p "${PWD}/.grok/commands" "${PWD}/.agents/commands" 2>/dev/null || true
  if [[ -d "${PWD}/.grok/commands" ]]; then
    install_dir "${PWD}/.grok/commands"
  fi
  if [[ -d "${PWD}/.agents/commands" ]]; then
    install_dir "${PWD}/.agents/commands"
  fi
fi

echo
echo "Done. In Grok/Claude, type / and search: tzai-icon, tzai-flowchart, tzai-xhs, …"
echo "Also ensure engine is installed:"
echo "  npx skills add kedoupi/tzai-image-skill -g --all"
echo "  export TZAI_API_KEY=...   # or tzai-image init"
