#!/usr/bin/env bash
# Install (or reinstall) every plugin in this marketplace via the Claude Code CLI.
# Safe to re-run: each plugin is reinstalled so local changes are always picked up.
#
# Usage: ./bin/install.sh [local|remote]
#   remote  (default) Install from the published marketplace on GitHub.
#   local             Install from this working copy, so local edits are picked up.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo_root/.claude-plugin/marketplace.json"

# Choose where to add the marketplace from.
mode="${1:-remote}"
case "$mode" in
  remote) source="jamescauwelier/claude-marketplace" ;;  # published marketplace on GitHub
  local)  source="$repo_root" ;;                          # this working copy
  *) echo "error: unknown mode '$mode' (expected 'local' or 'remote')" >&2; exit 1 ;;
esac

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

marketplace="$(jq -r '.name' "$manifest")"

# Register the marketplace (no-op if already present), then refresh it from source
# so re-runs see the latest catalog.
claude plugin marketplace add "$source" 2>/dev/null || true
claude plugin marketplace update "$marketplace"

# Reinstall each plugin so changes are picked up even when the version is unchanged
# (installed plugins are cached by version, so a plain install would no-op).
jq -r '.plugins[].name' "$manifest" | while read -r plugin; do
  claude plugin uninstall "$plugin@$marketplace" 2>/dev/null || true
  claude plugin install "$plugin@$marketplace"
done

echo "Done. Run /reload-plugins in your Claude Code session to pick up the skills."
