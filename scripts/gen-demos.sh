#!/usr/bin/env bash
# Generate README demo screenshots from docs/demos.tsv (requires TZAI_API_KEY).
# Usage:
#   bash scripts/gen-demos.sh              # all rows that need images
#   bash scripts/gen-demos.sh --only xhs cover wechat
#   bash scripts/gen-demos.sh --force      # regenerate even if file exists
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
BIN="${ROOT}/skills/tzai-image/scripts/tzai-image"
DEMOS="${ROOT}/docs/demos.tsv"
OUT_DIR="${ROOT}/docs/screenshots"
mkdir -p "$OUT_DIR"

FORCE=0
ONLY=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=1; shift ;;
    --only) shift; while [[ $# -gt 0 && "$1" != --* ]]; do ONLY+=("$1"); shift; done ;;
    -h|--help)
      sed -n '2,8p' "$0"
      exit 0
      ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

if ! command -v "$BIN" >/dev/null 2>&1 && [[ ! -x "$BIN" ]]; then
  echo "Missing engine: $BIN" >&2
  exit 1
fi

# Hard-fail early if no key (env or durable config)
if ! "$BIN" doctor >/dev/null 2>&1; then
  echo "API key missing or doctor failed. Configure TZAI_API_KEY or run: $BIN init --api-key sk-..." >&2
  "$BIN" doctor 2>&1 | tail -20 >&2 || true
  exit 1
fi

should_run() {
  local id="$1"
  if [[ ${#ONLY[@]} -eq 0 ]]; then return 0; fi
  local x
  for x in "${ONLY[@]}"; do
    [[ "$x" == "$id" ]] && return 0
  done
  return 1
}

n_ok=0
n_skip=0
n_fail=0

while IFS=$'\t' read -r id layer slash kind ar image prompt_zh highlight_zh; do
  [[ -z "${id:-}" || "$id" == \#* ]] && continue
  # skip header if present
  [[ "$id" == "id" ]] && continue
  should_run "$id" || continue

  # only generate kind-layer + missing category social assets that are unique files
  # Category rows often share kind images; only generate when kind_or_cat is a real kind
  # or image is not yet present.
  dest="${OUT_DIR}/${image}"

  # Map kind for engine
  gen_kind="$kind"
  if [[ "$layer" == "category" || "$layer" == "engine" ]]; then
    # categories reuse kind images; only generate if file missing and we can map a showcase kind
    case "$id" in
      brand) gen_kind=icon ;;
      diagram) gen_kind=architecture ;;
      product) gen_kind=ui ;;
      marketing) gen_kind=slide ;;
      social) gen_kind=xhs ;;
      photo) gen_kind=product-photo ;;
      engine) gen_kind=icon ;;
      *) gen_kind="" ;;
    esac
  fi

  if [[ -f "$dest" && "$FORCE" -eq 0 ]]; then
    echo "SKIP  $id  (exists $image)"
    n_skip=$((n_skip + 1))
    continue
  fi

  if [[ -z "$gen_kind" || "$gen_kind" == "(any)" ]]; then
    echo "SKIP  $id  (no kind)"
    n_skip=$((n_skip + 1))
    continue
  fi

  echo "GEN   $id  kind=$gen_kind  → $image"
  echo "      prompt: $prompt_zh"
  if "$BIN" "$gen_kind" --prompt "$prompt_zh" --ar "$ar" --image "$dest"; then
    echo "OK    $dest"
    n_ok=$((n_ok + 1))
  else
    echo "FAIL  $id" >&2
    n_fail=$((n_fail + 1))
  fi
done < "$DEMOS"

echo
echo "Done: ok=$n_ok skip=$n_skip fail=$n_fail"
[[ "$n_fail" -eq 0 ]]
