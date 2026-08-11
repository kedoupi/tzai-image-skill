#!/usr/bin/env bash
# Offline self-test for tzai-image (no network required).
set -euo pipefail

SOURCE_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
SOURCE_LOCAL_CONFIG="${SOURCE_ROOT}/skills/tzai-image/config.local.env"
SOURCE_LOCAL_SNAPSHOT=""
if [[ -f "$SOURCE_LOCAL_CONFIG" ]]; then
  SOURCE_LOCAL_SNAPSHOT="$(mktemp)"
  cp "$SOURCE_LOCAL_CONFIG" "$SOURCE_LOCAL_SNAPSHOT"
fi

TEST_ROOT="$(mktemp -d)/tzai-image-skill"
TEST_HOME="${TEST_ROOT}/home"
cleanup() {
  local status=$?
  local source_changed=0
  if [[ -n "$SOURCE_LOCAL_SNAPSHOT" && ! -f "$SOURCE_LOCAL_CONFIG" ]]; then
    echo "Source config.local.env was deleted" >&2
    source_changed=1
  fi
  if [[ -n "$SOURCE_LOCAL_SNAPSHOT" ]] && ! cmp -s "$SOURCE_LOCAL_SNAPSHOT" "$SOURCE_LOCAL_CONFIG"; then
    echo "Source config.local.env was changed" >&2
    source_changed=1
  fi
  rm -f "$SOURCE_LOCAL_SNAPSHOT"
  rm -rf "$(dirname -- "$TEST_ROOT")"
  [[ "$source_changed" -eq 0 ]] || return 1
  return "$status"
}
trap cleanup EXIT
mkdir -p "$TEST_ROOT" "$TEST_HOME"
cp -R "$SOURCE_ROOT/." "$TEST_ROOT"

# Exercise only a disposable skill package and config tree. Never touch a real local config.
ROOT="$TEST_ROOT"
BIN="${ROOT}/skills/tzai-image/scripts/tzai-image"
VALIDATOR="${ROOT}/skills/tzai-image/scripts/validate-workflow-plan"
export HOME="$TEST_HOME"
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

assert_fails() {
  local name="$1"
  shift
  set +e
  "$@" >/dev/null 2>&1
  local code=$?
  set -e
  if [[ "$code" -ne 0 ]]; then
    echo "  PASS  $name (exit $code)"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $name (unexpected success)"
    FAIL=$((FAIL + 1))
  fi
}

make_mock_curl() {
  MOCK_BIN="${ROOT}/mock-bin"
  MOCK_COUNT="${ROOT}/curl-count"
  mkdir -p "$MOCK_BIN"
  cat >"${MOCK_BIN}/curl" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf x >>"${MOCK_CURL_COUNT}"
out=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o) out="$2"; shift 2 ;;
    *) shift ;;
  esac
done
if [[ -n "$out" ]]; then
  case "${MOCK_CURL_RESPONSE:-b64}" in
    b64) printf '%s' '{"data":[{"b64_json":"iVBORw0KGgo="}]}' >"$out" ;;
    invalid-b64) printf '%s' '{"data":[{"b64_json":"!!!!"}]}' >"$out" ;;
    url) printf '%s' '{"data":[{"url":"https://example.invalid/image.png"}]}' >"$out" ;;
    *) printf '%s' '{"error":"unavailable"}' >"$out" ;;
  esac
fi
printf '%s' "${MOCK_CURL_CODE:-200}"
EOF
  cat >"${MOCK_BIN}/sleep" <<'EOF'
#!/usr/bin/env bash
exit 0
EOF
  chmod +x "${MOCK_BIN}/curl" "${MOCK_BIN}/sleep"
}

mock_curl_calls() {
  [[ -f "$MOCK_COUNT" ]] && wc -c <"$MOCK_COUNT" | tr -d ' ' || printf '0'
}

echo "== syntax =="
bash -n "$BIN"
echo "  PASS  bash -n"
PASS=$((PASS + 1))
python3 -m py_compile "$VALIDATOR"
echo "  PASS  workflow validator syntax"
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

echo "== generated surface consistency =="
bash "${ROOT}/scripts/gen-kind-skills.sh" >/dev/null
engine_version="$(awk -F'"' '/^[[:space:]]*version:/{print $2; exit}' "${ROOT}/skills/tzai-image/SKILL.md")"
while IFS= read -r skill; do
  version="$(awk -F'"' '/^[[:space:]]*version:/{print $2; exit}' "$skill")"
  assert_eq "thin version matches engine ($(basename "$(dirname "$skill")"))" "$engine_version" "$version"
  marker="$(awk '/tzai-generated-by: tzai-image-skill/{print; exit}' "$skill")"
  assert_contains "thin generated marker ($(basename "$(dirname "$skill")"))" "tzai-generated-by: tzai-image-skill" "$marker"
done < <(find "${ROOT}/skills" -mindepth 2 -maxdepth 2 -name SKILL.md ! -path "*/tzai-image/*" | sort)
while IFS= read -r command; do
  marker="$(awk '/tzai-generated-by: tzai-image-skill/{print; exit}' "$command")"
  assert_contains "command generated marker ($(basename "$command"))" "tzai-generated-by: tzai-image-skill" "$marker"
done < <(find "${ROOT}/commands" -maxdepth 1 -name 'tzai-*.md' | sort)

echo "== generated/install ownership boundaries =="
mkdir -p "${ROOT}/skills/tzai-handwritten"
printf '%s\n' 'handwritten skill' >"${ROOT}/skills/tzai-handwritten/SKILL.md"
printf '%s\n' 'handwritten command' >"${ROOT}/commands/tzai-handwritten.md"
mkdir -p "${ROOT}/skills/tzai-stale"
printf '%s\n' 'tzai-generated-by: tzai-image-skill' >"${ROOT}/skills/tzai-stale/SKILL.md"
printf '%s\n' 'tzai-generated-by: tzai-image-skill' >"${ROOT}/commands/tzai-stale.md"
bash "${ROOT}/scripts/gen-kind-skills.sh" >/dev/null
assert_ok "generator preserves handwritten skill" test -f "${ROOT}/skills/tzai-handwritten/SKILL.md"
assert_ok "generator preserves handwritten command" test -f "${ROOT}/commands/tzai-handwritten.md"
assert_exit "generator removes owned stale skill" 1 test -e "${ROOT}/skills/tzai-stale/SKILL.md"
assert_exit "generator removes owned stale command" 1 test -e "${ROOT}/commands/tzai-stale.md"

external_command="$(dirname -- "$ROOT")/external-command.md"
printf '%s\n' 'external sentinel' >"$external_command"
rm -f "${ROOT}/commands/tzai-icon.md"
ln -s "$external_command" "${ROOT}/commands/tzai-icon.md"
assert_fails "generator rejects symlink output" bash "${ROOT}/scripts/gen-kind-skills.sh"
assert_contains "generator leaves symlink target unchanged" "external sentinel" "$(<"$external_command")"
rm -f "${ROOT}/commands/tzai-icon.md"
bash "${ROOT}/scripts/gen-kind-skills.sh" >/dev/null

INSTALL_HOME="${ROOT}/install-home"
INSTALL_COMMANDS="${INSTALL_HOME}/.agents/commands"
mkdir -p "$INSTALL_COMMANDS"
printf '%s\n' 'keep same-name regular file' >"${INSTALL_COMMANDS}/tzai-icon.md"
printf '%s\n' 'keep custom regular file' >"${INSTALL_COMMANDS}/tzai-custom.md"
ln -s "${ROOT}/commands/tzai-stale.md" "${INSTALL_COMMANDS}/tzai-stale.md"
(
  cd "$ROOT"
  HOME="$INSTALL_HOME" bash scripts/install-slash-commands.sh >/dev/null
)
assert_contains "installer preserves same-name regular file" "keep same-name" "$(<"${INSTALL_COMMANDS}/tzai-icon.md")"
assert_ok "installer keeps stale managed link by default" test -L "${INSTALL_COMMANDS}/tzai-stale.md"
(
  cd "$ROOT"
  HOME="$INSTALL_HOME" bash scripts/install-slash-commands.sh --prune >/dev/null
)
assert_exit "installer prunes only managed stale link" 1 test -L "${INSTALL_COMMANDS}/tzai-stale.md"
assert_ok "installer preserves custom regular file" test -f "${INSTALL_COMMANDS}/tzai-custom.md"

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

echo "== config path and permissions =="
assert_fails "missing explicit config fails" env TZAI_IMAGE_CONFIG="${ROOT}/no-such-config.env" "$BIN" which-config
for mode in 0644 0660; do
  tmp_cfg="$(mktemp)"
  printf '%s\n' 'TZAI_API_KEY=sk-insecure-config' >"$tmp_cfg"
  chmod "$mode" "$tmp_cfg"
  assert_fails "key config mode ${mode} rejected" env TZAI_IMAGE_CONFIG="$tmp_cfg" "$BIN" which-config
  rm -f "$tmp_cfg"
done

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

echo "== --n validation =="
for n in nope 0 -1 2; do
  assert_exit "--n ${n} fails" 2 "$BIN" generate --dry-run --prompt "x" --image /tmp/t.png --n "$n"
done

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

echo "== --ref dry-run =="
ref_png="$(mktemp /tmp/tzai-ref-XXXXXX.png)"
# minimal 1x1 PNG
printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xf8\x0f\x00\x00\x01\x01\x00\x05\x18\xd8N\x00\x00\x00\x00IEND\xaeB`\x82' >"$ref_png" 2>/dev/null || \
  python3 -c "import base64,pathlib; pathlib.Path('$ref_png').write_bytes(base64.b64decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='))"
err="$("$BIN" illustration --dry-run --ref "$ref_png" --prompt "same series" --image /tmp/out.png 2>&1 >/dev/null)"
assert_contains "ref uses edits endpoint" "endpoint=edits" "$err"
assert_contains "ref path in dry-run" "refs=" "$err"
assert_exit "missing ref fails" 2 "$BIN" illustration --dry-run --ref /tmp/no-such-ref-$$.png --prompt "x" --image /tmp/o.png
assert_ok "workflows article" test -f "${ROOT}/skills/tzai-image/references/workflows/article-illustrate.md"
assert_ok "workflows slide-deck" test -f "${ROOT}/skills/tzai-image/references/workflows/slide-deck.md"
rm -f "$ref_png"

echo "== offline generation response contracts =="
make_mock_curl
mock_env=(env -u TZAI_IMAGE_CONFIG TZAI_API_KEY=sk-mock-key PATH="${MOCK_BIN}:$PATH" MOCK_CURL_COUNT="$MOCK_COUNT")
out_image="${ROOT}/generated.png"
printf '%s' 'existing-output' >"$out_image"
rm -f "$MOCK_COUNT"
assert_fails "existing output rejected without --force" "${mock_env[@]}" "$BIN" generate --prompt "x" --image "$out_image"
assert_eq "rejected output makes no curl" "0" "$(mock_curl_calls)"
rm -f "$MOCK_COUNT"
assert_ok "--force overwrites existing output" "${mock_env[@]}" "$BIN" generate --force --prompt "x" --image "$out_image"
assert_eq "successful CLI call makes one curl" "1" "$(mock_curl_calls)"
assert_ok "forced output replaced" test "$(wc -c <"$out_image" | tr -d ' ')" -ne 15

url_image="${ROOT}/url-only.png"
rm -f "$MOCK_COUNT"
assert_fails "URL-only response rejected" "${mock_env[@]}" MOCK_CURL_RESPONSE=url "$BIN" generate --prompt "x" --image "$url_image"
assert_eq "URL-only response makes one curl" "1" "$(mock_curl_calls)"

printf '%s' 'preserve-on-invalid-response' >"$out_image"
rm -f "$MOCK_COUNT"
assert_fails "invalid base64 rejected" "${mock_env[@]}" MOCK_CURL_RESPONSE=invalid-b64 "$BIN" generate --force --prompt "x" --image "$out_image"
assert_eq "invalid base64 makes one curl" "1" "$(mock_curl_calls)"
assert_eq "invalid base64 preserves existing output" "preserve-on-invalid-response" "$(<"$out_image")"

for code in 503 000; do
  rm -f "$MOCK_COUNT"
  assert_fails "HTTP ${code} fails without retry" "${mock_env[@]}" MOCK_CURL_CODE="$code" "$BIN" generate --prompt "x" --image "${ROOT}/http-${code}.png"
  assert_eq "HTTP ${code} makes one curl" "1" "$(mock_curl_calls)"
done

echo "== agent workflow catalogs =="
catalog_json="$("$VALIDATOR" --catalog-only --json)"
assert_contains "catalog has 27 workflows" '"workflows": 27' "$catalog_json"
assert_contains "catalog has 22 patterns" '"patterns": 22' "$catalog_json"
assert_contains "catalog has existing kinds" '"kinds": 30' "$catalog_json"
assert_ok "creative brief schema" test -f "${ROOT}/skills/tzai-image/references/schemas/creative-brief.schema.json"
assert_ok "asset plan schema" test -f "${ROOT}/skills/tzai-image/references/schemas/asset-plan.schema.json"
assert_ok "deliverables schema" test -f "${ROOT}/skills/tzai-image/references/schemas/deliverables.schema.json"
assert_ok "intent routing fixtures" test -f "${ROOT}/tests/fixtures/intent-routing.tsv"
stable_count="$(awk -F '\t' '$1 !~ /^#/ && $3 == "stable" {n++} END {print n+0}' "${ROOT}/skills/tzai-image/references/workflows/index.tsv")"
assert_eq "ten stable workflows" "10" "$stable_count"

echo "== workflow approval validator =="
wf_fixtures="${ROOT}/tests/fixtures/workflows"
assert_ok "ready for anchor" "$VALIDATOR" --for-anchor "${wf_fixtures}/xhs-ready-anchor.json"
assert_exit "anchor pending blocks batch" 2 "$VALIDATOR" --for-batch "${wf_fixtures}/xhs-ready-anchor.json"
mkdir -p "${wf_fixtures}/batch-output/assets"
printf '%s' 'approved-anchor' >"${wf_fixtures}/batch-output/assets/01-cover.png"
assert_ok "ready for batch" "$VALIDATOR" --for-batch "${wf_fixtures}/xhs-ready-batch.json"
assert_exit "duplicate output rejected" 2 "$VALIDATOR" --for-batch "${wf_fixtures}/invalid-duplicate-output.json"

pending_plan="${ROOT}/pending-plan.json"
python3 - "${wf_fixtures}/xhs-ready-anchor.json" "$pending_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["approval"]["plan"] = "pending"
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "pending plan blocks anchor" 2 "$VALIDATOR" --for-anchor "$pending_plan"

traversal_plan="${ROOT}/traversal-plan.json"
python3 - "${wf_fixtures}/xhs-ready-batch.json" "$traversal_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["assets"][1]["output"] = "../escape.png"
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "path traversal rejected" 2 "$VALIDATOR" --for-batch "$traversal_plan"

bad_kind_plan="${ROOT}/bad-kind-plan.json"
python3 - "${wf_fixtures}/xhs-ready-anchor.json" "$bad_kind_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["assets"][1]["kind"] = "icon"
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "workflow kind mismatch rejected" 2 "$VALIDATOR" --for-anchor "$bad_kind_plan"

missing_field_plan="${ROOT}/missing-field-plan.json"
python3 - "${wf_fixtures}/xhs-ready-anchor.json" "$missing_field_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
del data["assets"][1]["role"]
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "missing required asset field rejected" 2 "$VALIDATOR" --for-anchor "$missing_field_plan"

bad_force_plan="${ROOT}/bad-force-plan.json"
python3 - "${wf_fixtures}/xhs-ready-anchor.json" "$bad_force_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["assets"][0]["force"] = "true"
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "non-boolean force rejected" 2 "$VALIDATOR" --for-anchor "$bad_force_plan"

directory_output_plan="${ROOT}/directory-output-plan.json"
python3 - "${wf_fixtures}/xhs-ready-anchor.json" "$directory_output_plan" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["assets"][0]["output"] = "."
data["assets"][0]["force"] = True
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "project root output rejected" 2 "$VALIDATOR" --for-anchor "$directory_output_plan"

bad_anchor_state="${ROOT}/bad-anchor-state.json"
python3 - "${wf_fixtures}/xhs-ready-batch.json" "$bad_anchor_state" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text())
data["project_root"] = str(pathlib.Path(sys.argv[2]).parent / "bad-anchor-output")
data["assets"][0]["status"] = "planned"
pathlib.Path(sys.argv[2]).write_text(json.dumps(data))
PY
assert_exit "batch requires generated anchor state and file" 2 "$VALIDATOR" --for-batch "$bad_anchor_state"

make_mock_curl
rm -f "$MOCK_COUNT"
PATH="${MOCK_BIN}:$PATH" MOCK_CURL_COUNT="$MOCK_COUNT" "$VALIDATOR" --catalog-only >/dev/null
assert_eq "validator makes no curl calls" "0" "$(mock_curl_calls)"

echo "== live smoke (optional TZAI_LIVE=1) =="
if [[ "${TZAI_LIVE:-}" == "1" ]]; then
  live_out="$(mktemp /tmp/tzai-live-XXXXXX.png)"
  if "$BIN" icon --prompt "tiny blue spark app icon, no text" --ar 1:1 --image "$live_out"; then
    assert_ok "live generate wrote file" test -s "$live_out"
    echo "  PASS  live generate path=$live_out"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  live generate"
    FAIL=$((FAIL + 1))
  fi
  # optional ref smoke if we have a live file
  if [[ -s "$live_out" ]]; then
    live2="$(mktemp /tmp/tzai-live2-XXXXXX.png)"
    if "$BIN" icon --ref "$live_out" --prompt "same spark metaphor, slightly different blue" --ar 1:1 --image "$live2"; then
      assert_ok "live ref edit wrote file" test -s "$live2"
    else
      echo "  FAIL  live --ref"
      FAIL=$((FAIL + 1))
    fi
    rm -f "$live2"
  fi
  rm -f "$live_out"
else
  echo "  SKIP  set TZAI_LIVE=1 to run one real generation"
fi

echo
echo "Results: ${PASS} passed, ${FAIL} failed"
[[ "$FAIL" -eq 0 ]]
