#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd || printf '%s' "$ROOT")"
OUT="${ARCH_REVIEW_OUT_DIR:-$(mktemp -d "${TMPDIR:-/tmp}/architecture-review-go-XXXXXX")}"
mkdir -p "$OUT"
echo "Output directory: $OUT"

find "$ROOT" -maxdepth 5 -name '*.go' -not -path '*/vendor/*' | head -1 | grep -q . || {
  echo "No Go files found" | tee "$OUT/skipped.txt"
  exit 0
}

if command -v go >/dev/null 2>&1 && [ -f "$ROOT/go.mod" ]; then
  (cd "$ROOT" && go test ./...) >"$OUT/go-test.txt" 2>&1 || true
  (cd "$ROOT" && go vet ./...) >"$OUT/go-vet.txt" 2>&1 || true
else
  echo "SKIPPED: go not found or go.mod missing" >"$OUT/go-test.txt"
  echo "SKIPPED: go not found or go.mod missing" >"$OUT/go-vet.txt"
fi

for cmd in staticcheck gocyclo govulncheck gosec; do
  if command -v "$cmd" >/dev/null 2>&1; then
    case "$cmd" in
      staticcheck|govulncheck|gosec) (cd "$ROOT" && "$cmd" ./...) >"$OUT/$cmd.txt" 2>&1 || true ;;
      gocyclo) (cd "$ROOT" && "$cmd" -over 15 .) >"$OUT/$cmd.txt" 2>&1 || true ;;
    esac
  else
    echo "SKIPPED: $cmd not found" >"$OUT/$cmd.txt"
  fi
done

echo "$OUT"
