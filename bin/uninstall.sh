#!/usr/bin/env bash
# Uninstall every plugin in this marketplace, then remove the marketplace itself.
#
# Usage: ./bin/uninstall.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo_root/.claude-plugin/marketplace.json"

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

marketplace="$(jq -r '.name' "$manifest")"

jq -r '.plugins[].name' "$manifest" | while read -r plugin; do
  claude plugin uninstall "$plugin@$marketplace" || true
done

claude plugin marketplace remove "$marketplace" || true
