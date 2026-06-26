#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd || printf '%s' "$ROOT")"

echo "# Project Detection"
echo
echo "Repository root: $ROOT"
echo

if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "## Git"
  echo "- Branch: $(git -C "$ROOT" branch --show-current 2>/dev/null || true)"
  echo "- HEAD: $(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || true)"
  echo "- Changed files: $(git -C "$ROOT" status --short 2>/dev/null | wc -l | tr -d ' ')"
  echo
fi

echo "## Manifests"
for f in package.json pnpm-lock.yaml package-lock.json yarn.lock bun.lockb pyproject.toml requirements.txt go.mod Cargo.toml pom.xml build.gradle settings.gradle composer.json Gemfile; do
  [ -e "$ROOT/$f" ] && echo "- $f"
done
echo

echo "## Guidance docs"
find "$ROOT" -maxdepth 3 \( -name README.md -o -name CLAUDE.md -o -name AGENTS.md -o -name CONTEXT.md -o -name ARCHITECTURE.md -o -path '*/docs/adr/*' \) -type f 2>/dev/null | sed "s#^$ROOT/#- #" | sort | head -100

echo
echo "## Approximate file counts"
for ext in ts tsx js jsx py go java kt rs rb php cs cpp c h hpp sql proto md; do
  count=$(find "$ROOT" -type f -name "*.$ext" -not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/vendor/*' 2>/dev/null | wc -l | tr -d ' ')
  [ "$count" != "0" ] && echo "- .$ext: $count"
done
