#!/usr/bin/env bash
# Offline self-test for tzai-image (no network required).
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
BIN="${ROOT}/skills/tzai-image/scripts/tzai-image"
PASS=0
FAIL=0

assert_ok() {
  local name="$1"
  shift
  if "$@"; then
    echo "  PASS  $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $name"
    FAIL=$((FAIL + 1))
  fi
}

assert_eq() {
  local name="$1" expected="$2" actual="$3"
  if [[ "$expected" == "$actual" ]]; then
    echo "  PASS  $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $name (expected='$expected' actual='$actual')"
    FAIL=$((FAIL + 1))
  fi
}

assert_contains() {
  local name="$1" needle="$2" hay="$3"
  if [[ "$hay" == *"$needle"* ]]; then
    echo "  PASS  $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $name (missing '$needle')"
    FAIL=$((FAIL + 1))
  fi
}

assert_exit() {
  local name="$1" want="$2"
  shift 2
  set +e
  "$@" >/dev/null 2>&1
  local code=$?
  set -e
  if [[ "$code" -eq "$want" ]]; then
    echo "  PASS  $name (exit $want)"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $name (exit $code want $want)"
    FAIL=$((FAIL + 1))
  fi
}

echo "== syntax =="
bash -n "$BIN"
echo "  PASS  bash -n"
PASS=$((PASS + 1))

echo "== help / version =="
"$BIN" --help >/dev/null
ver="$("$BIN" --version)"
assert_contains "version string" "tzai-image v" "$ver"

echo "== dry-run without key =="
err="$("$BIN" generate --dry-run --prompt "a cat" --image /tmp/t.png 2>&1 >/dev/null)"
assert_contains "dry-run meta" "[dry-run] not calling network" "$err"
assert_contains "dry-run default best model" "gpt-image-2" "$err"

echo "== dry-run model override =="
err="$("$BIN" generate --dry-run --prompt "a cat" --image /tmp/t.png --model demo-model 2>&1 >/dev/null)"
assert_contains "dry-run override model" "demo-model" "$err"

echo "== kinds catalog =="
kinds_out="$("$BIN" kinds 2>&1)"
assert_contains "kinds has flowchart" "flowchart" "$kinds_out"
assert_contains "kinds has xhs" "xhs" "$kinds_out"
assert_contains "kinds has icon" "icon" "$kinds_out"
detail="$("$BIN" kinds flowchart 2>&1)"
assert_contains "kind detail ar" "16:9" "$detail"

echo "== kind enriches prompt (dry-run) =="
err="$("$BIN" generate --dry-run --kind icon --prompt "spark AI" --image /tmp/i.png 2>&1 >/dev/null)"
assert_contains "kind in dry-run" "kind=icon" "$err"
assert_contains "kind default ar 1:1" "ar=1:1" "$err"
err="$("$BIN" xhs --dry-run --prompt "三步周报" --image /tmp/x.png 2>&1 >/dev/null)"
assert_contains "xhs alias kind" "kind=xhs" "$err"
assert_contains "xhs ar 3:4" "ar=3:4" "$err"

echo "== missing prompt =="
assert_exit "empty prompt fails" 2 "$BIN" generate --dry-run --prompt "" --image /tmp/t.png --model m

echo "== missing key on real generate (no network path) =="
# unset key and avoid durable config pollution: use empty env
out="$(env -u TZAI_API_KEY -u TZAI_IMAGE_CONFIG \
  "$BIN" generate --prompt "x" --image /tmp/nope.png --model m 2>&1)" || true
assert_contains "missing key hints console" "tzai.kdp.cool" "$out"
assert_contains "missing key hints export" "TZAI_API_KEY" "$out"

echo "== env key source (dry-run) =="
err="$(TZAI_API_KEY='sk-envtest123456' "$BIN" generate --dry-run \
  --prompt "hi" --image /tmp/t.png --model m 2>&1 >/dev/null)"
assert_contains "key source env" "source: env" "$err"
assert_contains "key masked" "sk-e" "$err"

echo "== init local + which-config =="
tmp_local="${ROOT}/skills/tzai-image/config.local.env"
rm -f "$tmp_local"
"$BIN" init --target local --api-key 'sk-filekey-abcdef' --model 'file-model' --force >/dev/null
assert_ok "local config exists" test -f "$tmp_local"
# env should win over file
err="$(TZAI_API_KEY='sk-env-wins-zzzz' env TZAI_IMAGE_CONFIG= \
  "$BIN" generate --dry-run --prompt "p" --image /tmp/t.png 2>&1 >/dev/null)"
# model may still come from file if not in env — key source env
assert_contains "env overrides file key" "source: env" "$err"
wc="$("$BIN" which-config 2>/dev/null || true)"
assert_contains "which-config shows model" "file-model" "$wc"
rm -f "$tmp_local"

echo "== doctor without key =="
set +e
doc="$(env -u TZAI_API_KEY "$BIN" doctor 2>&1)"
dc=$?
set -e
assert_contains "doctor fail key" "[FAIL]" "$doc"
assert_contains "doctor console" "console" "$doc"
# doctor exits non-zero when fail
if [[ "$dc" -ne 0 ]]; then
  echo "  PASS  doctor exit non-zero"
  PASS=$((PASS + 1))
else
  echo "  FAIL  doctor exit non-zero"
  FAIL=$((FAIL + 1))
fi

echo
echo "Results: ${PASS} passed, ${FAIL} failed"
[[ "$FAIL" -eq 0 ]]
