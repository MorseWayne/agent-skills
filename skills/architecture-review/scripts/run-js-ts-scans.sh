#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd || printf '%s' "$ROOT")"
OUT="${ARCH_REVIEW_OUT_DIR:-$(mktemp -d "${TMPDIR:-/tmp}/architecture-review-js-ts-XXXXXX")}"
mkdir -p "$OUT"
echo "Output directory: $OUT"

has_js=0
[ -f "$ROOT/package.json" ] && has_js=1
find "$ROOT" -maxdepth 4 \( -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' \) -not -path '*/node_modules/*' | head -1 | grep -q . && has_js=1
if [ "$has_js" != "1" ]; then
  echo "No JS/TS project markers found" | tee "$OUT/skipped.txt"
  exit 0
fi

run_if_available() {
  cmd="$1"; outfile="$2"; shift 2
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "Running $cmd -> $outfile"
    (cd "$ROOT" && "$cmd" "$@") >"$OUT/$outfile" 2>&1 || true
  else
    echo "SKIPPED: $cmd not found" | tee "$OUT/$outfile"
  fi
}

run_if_available knip knip.txt
run_if_available jscpd jscpd.txt --silent --reporters console .
run_if_available madge madge-circular.txt --circular .

if command -v depcruise >/dev/null 2>&1; then
  (cd "$ROOT" && depcruise --output-type err .) >"$OUT/dependency-cruiser.txt" 2>&1 || true
elif command -v dependency-cruiser >/dev/null 2>&1; then
  (cd "$ROOT" && dependency-cruiser --output-type err .) >"$OUT/dependency-cruiser.txt" 2>&1 || true
else
  echo "SKIPPED: dependency-cruiser/depcruise not found" >"$OUT/dependency-cruiser.txt"
fi

if command -v eslint >/dev/null 2>&1; then
  (cd "$ROOT" && eslint .) >"$OUT/eslint.txt" 2>&1 || true
else
  echo "SKIPPED: eslint not found" >"$OUT/eslint.txt"
fi

if command -v biome >/dev/null 2>&1; then
  (cd "$ROOT" && biome check .) >"$OUT/biome.txt" 2>&1 || true
else
  echo "SKIPPED: biome not found" >"$OUT/biome.txt"
fi

echo "$OUT"
