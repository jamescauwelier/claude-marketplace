#!/usr/bin/env bash
# Install (or reinstall) every plugin from this working copy via the Claude Code CLI.
# Safe to re-run: each plugin is reinstalled so local changes are always picked up.
#
# This installs from the local checkout. To install from the published marketplace
# without cloning the repo, see "Install without cloning" in the README.
#
# Usage: ./bin/install.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo_root/.claude-plugin/marketplace.json"

command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }

marketplace="$(jq -r '.name' "$manifest")"

# Register the marketplace from this working copy (no-op if already present), then
# refresh it so re-runs see the latest catalog.
claude plugin marketplace add "$repo_root" 2>/dev/null || true
claude plugin marketplace update "$marketplace"

# Reinstall each plugin so changes are picked up even when the version is unchanged
# (installed plugins are cached by version, so a plain install would no-op).
jq -r '.plugins[].name' "$manifest" | while read -r plugin; do
  claude plugin uninstall "$plugin@$marketplace" 2>/dev/null || true
  claude plugin install "$plugin@$marketplace"
done

echo "Done. Run /reload-plugins in your Claude Code session to pick up the skills."
