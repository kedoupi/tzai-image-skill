#!/usr/bin/env bash
# Run a live before/after compare suite → artifacts/live/<suite>/<version>/
# Specs: tests/live/<suite>/cases.tsv
#
# Usage:
#   bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.2
#   bash scripts/run-live-compare.sh --suite pattern-compile --version v0.6.1 --only 07-flowchart
#   bash scripts/run-live-compare.sh --suite pattern-compile --version _scratch/local --force
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
CLI="${ROOT}/skills/tzai-image/scripts/tzai-image"

SUITE=""
VERSION=""
FORCE=0
ONLY=()

usage() {
  sed -n '2,10p' "$0"
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --suite) SUITE="${2:-}"; shift 2 ;;
    --version) VERSION="${2:-}"; shift 2 ;;
    --force) FORCE=1; shift ;;
    --only)
      shift
      while [[ $# -gt 0 && "$1" != --* ]]; do ONLY+=("$1"); shift; done
      ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown arg: $1" >&2; usage 2 ;;
  esac
done

[[ -n "$SUITE" && -n "$VERSION" ]] || { echo "Need --suite and --version" >&2; usage 2; }

CASES="${ROOT}/tests/live/${SUITE}/cases.tsv"
OUT_ROOT="${ROOT}/artifacts/live/${SUITE}/${VERSION}"
PAIRS="${OUT_ROOT}/pairs"

[[ -f "$CASES" ]] || { echo "Missing cases: $CASES" >&2; exit 1; }
[[ -x "$CLI" || -f "$CLI" ]] || { echo "Missing CLI: $CLI" >&2; exit 1; }

if ! bash "$CLI" doctor >/dev/null 2>&1; then
  echo "doctor failed / no API key" >&2
  bash "$CLI" doctor 2>&1 | tail -25 >&2 || true
  exit 1
fi

mkdir -p "$PAIRS"

should_run() {
  local id="$1"
  [[ ${#ONLY[@]} -eq 0 ]] && return 0
  local x
  for x in "${ONLY[@]}"; do [[ "$x" == "$id" ]] && return 0; done
  return 1
}

run_one() {
  local id="$1" kind="$2" mode="$3" prompt="$4" extra="$5"
  local dir="${PAIRS}/${id}"
  local img="${dir}/${mode}.png"
  mkdir -p "$dir"
  if [[ -f "$img" && "$FORCE" -ne 1 ]]; then
    echo "SKIP exists $img (use --force)"
    return 0
  fi
  local -a cmd=(bash "$CLI" generate --kind "$kind" --prompt "$prompt" --image "$img")
  [[ "$FORCE" -eq 1 ]] && cmd+=(--force)
  if [[ -n "${extra// }" ]]; then
    # shellcheck disable=SC2206
    local -a extra_args=($extra)
    cmd+=("${extra_args[@]}")
  fi
  echo "=== GEN ${id}/${mode} kind=${kind} ==="
  "${cmd[@]}"
}

n_ok=0
n_fail=0
n_skip=0

while IFS=$'\t' read -r id kind before after extra pattern; do
  [[ -z "${id:-}" || "$id" == \#* ]] && continue
  [[ "$id" == "id" ]] && continue
  should_run "$id" || continue

  if run_one "$id" "$kind" before "$before" ""; then
    n_ok=$((n_ok + 1))
  else
    n_fail=$((n_fail + 1))
    echo "FAIL ${id}/before" >&2
  fi
  if run_one "$id" "$kind" after "$after" "${extra:-}"; then
    n_ok=$((n_ok + 1))
  else
    n_fail=$((n_fail + 1))
    echo "FAIL ${id}/after" >&2
  fi
done < "$CASES"

REPORT="${OUT_ROOT}/report.md"
if [[ ! -f "$REPORT" ]]; then
  cat > "$REPORT" <<EOF
# Live report: ${SUITE} ${VERSION}

- Specs: \`tests/live/${SUITE}/cases.tsv\`
- Output: \`artifacts/live/${SUITE}/${VERSION}/\`
- Generated: $(date -u +%Y-%m-%dT%H:%MZ)
- Results: ok=${n_ok} fail=${n_fail}

Fill scores using \`tests/live/${SUITE}/rubric.md\`.
EOF
fi

echo
echo "Done: ok=${n_ok} fail=${n_fail}"
echo "Pairs: ${PAIRS}"
echo "Report: ${REPORT}"
[[ "$n_fail" -eq 0 ]]
