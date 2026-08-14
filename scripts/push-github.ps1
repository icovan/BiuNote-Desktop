# Push desktop/ to the public GitHub repo (no extra checkout).
#
# Usage (from desktop/):
#   powershell -NoProfile -ExecutionPolicy Bypass -File scripts/push-github.ps1
#
# Usage (from biu-pro root):
#   powershell -NoProfile -ExecutionPolicy Bypass -File desktop/scripts/push-github.ps1

$ErrorActionPreference = 'Stop'

$desktop = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$root = (Resolve-Path (Join-Path $desktop '..')).Path
Set-Location $root

$branch = (git rev-parse --abbrev-ref HEAD).Trim()
if ($branch -ne 'main' -and $branch -ne 'master') {
  throw ("push-github only runs on main/master (current: {0})" -f $branch)
}

$dirty = git status --porcelain -- desktop
if ($dirty) {
  Write-Host '[push-github] desktop/ has uncommitted changes. Commit the main repo first:'
  Write-Host '  git add desktop && git commit -m "..."'
  Write-Host '  powershell -File scripts/push-main.ps1'
  git status -sb -- desktop
  throw 'dirty desktop/'
}

$url = 'https://github.com/icovan/BiuNote-Desktop.git'
$remote = 'desktop-github'
$names = @(git remote)
if ($names -notcontains $remote) {
  git remote add $remote $url
} else {
  git remote set-url $remote $url
}

Write-Host ("[push-github] {0}  prefix=desktop  ->  {1}" -f $branch, $url)
# Version-bump hook is for Gitee product pushes only.
$env:BIUPRO_SKIP_VERSION_BUMP = '1'
try {
  git subtree push --prefix=desktop $remote main
  if ($LASTEXITCODE -ne 0) { throw 'git subtree push failed' }
} finally {
  Remove-Item Env:BIUPRO_SKIP_VERSION_BUMP -ErrorAction SilentlyContinue
}
Write-Host '[push-github] OK  https://github.com/icovan/BiuNote-Desktop'
