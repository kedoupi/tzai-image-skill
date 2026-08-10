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
assert_contains "kinds has mindmap long-tail" "mindmap" "$kinds_out"
detail="$("$BIN" kinds flowchart 2>&1)"
assert_contains "kind detail ar" "16:9" "$detail"

echo "== Plan C slash whitelist =="
WHITE="${ROOT}/skills/tzai-image/references/slash-whitelist.txt"
assert_ok "whitelist exists" test -f "$WHITE"
# high-freq kinds must have thin skills; long-tail mindmap must not
assert_ok "slash skill xhs" test -f "${ROOT}/skills/tzai-xhs/SKILL.md"
assert_ok "slash skill icon" test -f "${ROOT}/skills/tzai-icon/SKILL.md"
assert_ok "hub skill brand" test -f "${ROOT}/skills/tzai-brand/SKILL.md"
assert_ok "hub skill diagram" test -f "${ROOT}/skills/tzai-diagram/SKILL.md"
assert_exit "no thin skill for long-tail mindmap" 1 test -f "${ROOT}/skills/tzai-mindmap/SKILL.md"
assert_exit "no thin skill for long-tail food" 1 test -f "${ROOT}/skills/tzai-food/SKILL.md"
# count thin+hub skills (exclude engine)
n_slash="$(find "${ROOT}/skills" -mindepth 1 -maxdepth 1 -type d ! -name tzai-image | wc -l | tr -d ' ')"
# 6 hubs + 11 kinds = 17
assert_eq "plan-c slash skill count" "17" "$n_slash"

echo "== kind enriches prompt (dry-run) =="
err="$("$BIN" generate --dry-run --kind icon --prompt "spark AI" --image /tmp/i.png 2>&1 >/dev/null)"
assert_contains "kind in dry-run" "kind=icon" "$err"
assert_contains "kind default ar 1:1" "ar=1:1" "$err"
err="$("$BIN" xhs --dry-run --prompt "三步周报" --image /tmp/x.png 2>&1 >/dev/null)"
assert_contains "xhs alias kind" "kind=xhs" "$err"
assert_contains "xhs ar 3:4" "ar=3:4" "$err"

echo "== P0 matrix knobs (dry-run) =="
assert_ok "presets dir" test -d "${ROOT}/skills/tzai-image/references/presets"
presets_out="$("$BIN" presets xhs 2>&1)"
assert_contains "presets lists notion style" "notion" "$presets_out"
assert_contains "presets lists dense layout" "dense" "$presets_out"
assert_contains "presets lists knowledge-card" "knowledge-card" "$presets_out"
err="$("$BIN" xhs --dry-run --style notion --layout dense --prompt "周报" --image /tmp/x.png 2>&1 >/dev/null)"
assert_contains "matrix style in dry-run" "style=notion" "$err"
assert_contains "matrix layout in dry-run" "layout=dense" "$err"
# final prompt should grow when matrix applied
json="$("$BIN" xhs --dry-run --json --style notion --layout dense --prompt "周报" --image /tmp/x.png 2>/dev/null)"
assert_contains "json has style" '"style": "notion"' "$json"
fp_len="$(python3 -c "import json,sys; print(len(json.loads(sys.argv[1])['final_prompt']))" "$json")"
assert_ok "matrix final_prompt longer than 80" test "$fp_len" -gt 80
err="$("$BIN" xhs --dry-run --preset knowledge-card --prompt "周报" --image /tmp/x.png 2>&1 >/dev/null)"
assert_contains "preset expands" "preset=knowledge-card" "$err"
assert_contains "preset sets style" "style=notion" "$err"
err="$("$BIN" infographic --dry-run --layout funnel --style tech-schematic --prompt "转化" --image /tmp/i.png 2>&1 >/dev/null)"
assert_contains "infographic layout" "layout=funnel" "$err"
assert_contains "infographic style" "style=tech-schematic" "$err"
err="$("$BIN" cover --dry-run --type hero --palette dark --mood bold --text none --prompt "主题" --image /tmp/c.png 2>&1 >/dev/null)"
assert_contains "cover type" "type=hero" "$err"
assert_contains "cover palette" "palette=dark" "$err"
assert_contains "cover mood" "mood=bold" "$err"
assert_exit "bad style fails" 2 "$BIN" xhs --dry-run --style not-a-style --prompt "x" --image /tmp/x.png

echo "== invalid --ar =="
assert_exit "bad ar fails" 2 "$BIN" generate --dry-run --kind icon --ar 99:99 --prompt "x" --image /tmp/t.png
err="$("$BIN" generate --dry-run --kind icon --ar 99:99 --prompt "x" --image /tmp/t.png 2>&1 >/dev/null)" || true
assert_contains "bad ar message" "Supported:" "$err"

echo "== kind alias product → product-photo =="
err="$("$BIN" product --dry-run --prompt "speaker" --image /tmp/p.png 2>&1 >/dev/null)"
assert_contains "alias note" "product-photo" "$err"
assert_contains "alias kind in dry-run" "kind=product-photo" "$err"
kinds_out="$("$BIN" kinds 2>&1)"
assert_contains "kinds lists product-photo" "product-photo" "$kinds_out"

echo "== --json escapes special prompt chars =="
json="$("$BIN" generate --dry-run --json --kind icon --prompt 'hello """ break' --image /tmp/t.png 2>/dev/null)"
python3 -c "import json,sys; d=json.loads(sys.argv[1]); assert '\"\"\"' in d['final_prompt'] or d['final_prompt'].count('\"')>=3; print('ok')" "$json" >/dev/null
assert_ok "json parses with triple-quote prompt" true
assert_contains "json final_prompt has hello" "hello" "$json"

echo "== safe config parse (no shell source) =="
tmp_cfg="$(mktemp)"
cat >"$tmp_cfg" <<'EOF'
# comment
TZAI_API_KEY=sk-safeparse-abcdef
TZAI_IMAGE_MODEL=safe-model
EVIL=$(echo pwned)
HOME=/tmp/should-not-apply
EOF
err="$(env -u TZAI_API_KEY TZAI_IMAGE_CONFIG="$tmp_cfg" \
  "$BIN" generate --dry-run --prompt "p" --image /tmp/t.png 2>&1 >/dev/null)"
assert_contains "safe config key loaded" "source: explicit-file" "$err"
assert_contains "safe config key masked" "sk-s" "$err"
# EVIL must not execute; model from file should load
err2="$(env -u TZAI_API_KEY -u TZAI_IMAGE_MODEL TZAI_IMAGE_CONFIG="$tmp_cfg" \
  "$BIN" which-config 2>&1)"
assert_contains "safe config model" "safe-model" "$err2"
rm -f "$tmp_cfg"

echo "== missing prompt =="
assert_exit "empty prompt fails" 2 "$BIN" generate --dry-run --prompt "" --image /tmp/t.png --model m

echo "== missing key on real generate (no network path) =="
# Isolate from durable/global keys (HOME points to empty tree)
out="$(
  env -u TZAI_API_KEY -u TZAI_IMAGE_CONFIG \
    HOME="${TMPDIR:-/tmp}/tzai-test-home-gen-$$" \
    "$BIN" generate --prompt "x" --image /tmp/nope.png --model m 2>&1
)" || true
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
# Isolate from durable/global/local env files so CI/dev machines with real keys still pass.
set +e
doc="$(
  env -u TZAI_API_KEY -u TZAI_IMAGE_CONFIG \
    HOME="${TMPDIR:-/tmp}/tzai-test-home-$$" \
    "$BIN" doctor 2>&1
)"
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
