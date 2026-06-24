#!/usr/bin/env bash
set -euo pipefail

REPO="${ENTERPRISE_SITE_WORKFLOW_REPO:-YOUR_GITHUB_USERNAME/enterprise-website-workflow-kit}"
REF="${ENTERPRISE_SITE_WORKFLOW_REF:-main}"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
INSTALLER="$CODEX_HOME_DIR/skills/.system/skill-installer/scripts/install-skill-from-github.py"

if [ ! -f "$INSTALLER" ]; then
  echo "Codex skill-installer was not found at $INSTALLER" >&2
  echo "Open Codex once, or install this skill manually from the repo." >&2
  exit 1
fi

if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
else
  echo "Python was not found." >&2
  exit 1
fi

echo "Installing enterprise-website-delivery from $REPO@$REF ..."
"$PYTHON_BIN" "$INSTALLER" --repo "$REPO" --ref "$REF" --path "skills/enterprise-website-delivery"

if [ "${WITH_DESIGN_SKILLS:-0}" = "1" ]; then
  echo "Installing design-taste-frontend ..."
  "$PYTHON_BIN" "$INSTALLER" --repo "Leonxlnx/taste-skill" --path "skills/taste-skill"

  echo "Installing ui-ux-pro-max ..."
  "$PYTHON_BIN" "$INSTALLER" --repo "nextlevelbuilder/ui-ux-pro-max-skill" --path ".claude/skills/ui-ux-pro-max"
fi

echo
echo "Done. Restart Codex to pick up newly installed skills."

