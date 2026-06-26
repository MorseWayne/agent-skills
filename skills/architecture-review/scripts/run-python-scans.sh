#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd || printf '%s' "$ROOT")"
OUT="${ARCH_REVIEW_OUT_DIR:-$(mktemp -d "${TMPDIR:-/tmp}/architecture-review-python-XXXXXX")}"
mkdir -p "$OUT"
echo "Output directory: $OUT"

find "$ROOT" -maxdepth 5 -name '*.py' -not -path '*/.venv/*' -not -path '*/venv/*' | head -1 | grep -q . || {
  echo "No Python files found" | tee "$OUT/skipped.txt"
  exit 0
}

run_if_available() {
  cmd="$1"; outfile="$2"; shift 2
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "Running $cmd -> $outfile"
    (cd "$ROOT" && "$cmd" "$@") >"$OUT/$outfile" 2>&1 || true
  else
    echo "SKIPPED: $cmd not found" | tee "$OUT/$outfile"
  fi
}

run_if_available ruff ruff.txt check .
run_if_available radon radon-cc.txt cc . -s -a
run_if_available radon radon-mi.txt mi . -s
run_if_available vulture vulture.txt .
run_if_available bandit bandit.txt -r .

echo "$OUT"
