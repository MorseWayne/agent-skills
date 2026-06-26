#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd || printf '%s' "$ROOT")"
OUT="${ARCH_REVIEW_OUT_DIR:-$(mktemp -d "${TMPDIR:-/tmp}/architecture-review-common-XXXXXX")}"
mkdir -p "$OUT"
echo "Output directory: $OUT"

run_tool() {
  name="$1"; shift
  outfile="$1"; shift
  if command -v "$name" >/dev/null 2>&1; then
    echo "Running $name -> $outfile"
    (cd "$ROOT" && "$name" "$@") >"$OUT/$outfile" 2>&1 || true
  else
    echo "SKIPPED: $name not found" | tee "$OUT/$outfile"
  fi
}

run_tool tokei tokei.txt "$ROOT"
run_tool cloc cloc.txt "$ROOT"
run_tool scc scc.txt "$ROOT"

if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$ROOT" ls-files | while read -r f; do
    [ -f "$ROOT/$f" ] && wc -l "$ROOT/$f"
  done | sort -nr | head -50 >"$OUT/largest-files.txt" 2>/dev/null || true
  git -C "$ROOT" status --short >"$OUT/git-status.txt" 2>&1 || true
  git -C "$ROOT" log --format='%h %ad %s' --date=short -n 100 >"$OUT/recent-commits.txt" 2>&1 || true
fi

if command -v semgrep >/dev/null 2>&1; then
  (cd "$ROOT" && semgrep scan --config auto --json) >"$OUT/semgrep.json" 2>"$OUT/semgrep.stderr" || true
else
  echo "SKIPPED: semgrep not found" >"$OUT/semgrep.json"
fi

if command -v gitleaks >/dev/null 2>&1; then
  gitleaks detect --source "$ROOT" --no-git --redact --report-format json --report-path "$OUT/gitleaks.json" >"$OUT/gitleaks.stdout" 2>&1 || true
else
  echo "SKIPPED: gitleaks not found" >"$OUT/gitleaks.json"
fi

echo "$OUT"
