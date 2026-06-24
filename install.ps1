param(
  [string]$Repo = "kzzzp/enterprise-website-workflow-kit",
  [string]$Ref = "main",
  [switch]$WithDesignSkills
)

$ErrorActionPreference = "Stop"

$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$installer = Join-Path $codexHome "skills/.system/skill-installer/scripts/install-skill-from-github.py"

if (-not (Test-Path -LiteralPath $installer)) {
  throw "Codex skill-installer was not found at $installer. Open Codex once, or install this skill manually from the repo."
}

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
  $python = Get-Command py -ErrorAction SilentlyContinue
}
if (-not $python) {
  throw "Python was not found. Install Python or run the Codex skill-installer manually."
}

Write-Host "Installing enterprise-website-delivery from $Repo@$Ref ..."
& $python.Source $installer --repo $Repo --ref $Ref --path "skills/enterprise-website-delivery"

$installDesignSkills = $WithDesignSkills -or ($env:WITH_DESIGN_SKILLS -eq "1")
if ($installDesignSkills) {
  Write-Host "Installing design-taste-frontend ..."
  & $python.Source $installer --repo "Leonxlnx/taste-skill" --path "skills/taste-skill"

  Write-Host "Installing ui-ux-pro-max ..."
  & $python.Source $installer --repo "nextlevelbuilder/ui-ux-pro-max-skill" --path ".claude/skills/ui-ux-pro-max"
}

Write-Host ""
Write-Host "Done. Restart Codex to pick up newly installed skills."
