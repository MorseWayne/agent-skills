#!/usr/bin/env bash
set -u
DIR="${1:-.}"
if [ ! -d "$DIR" ]; then
  echo "Usage: $0 <scan-output-dir>" >&2
  exit 2
fi

echo "# Scan Output Summary"
echo
echo "Directory: $DIR"
echo
for f in "$DIR"/*; do
  [ -f "$f" ] || continue
  name="$(basename "$f")"
  echo "## $name"
  if grep -q '^SKIPPED:' "$f" 2>/dev/null; then
    head -5 "$f"
  else
    echo "- Lines: $(wc -l < "$f" | tr -d ' ')"
    echo "- Size: $(wc -c < "$f" | tr -d ' ') bytes"
    echo
    head -40 "$f"
  fi
  echo
done
