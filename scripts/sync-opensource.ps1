# Sync biu-pro/desktop → public biunote-desktop checkout, then optional commit/push.
# Usage (from anywhere):
#   powershell -File E:\SIM+\biu-pro\desktop\scripts\sync-opensource.ps1
#   powershell -File ...\sync-opensource.ps1 -Commit -Push -Message "sync: desktop shell"
#
# Env override: $env:BIUNOTE_OPEN_DIR = "E:\open\biunote-desktop"

param(
  [string]$OpenDir = $(if ($env:BIUNOTE_OPEN_DIR) { $env:BIUNOTE_OPEN_DIR } else { 'E:\open\biunote-desktop' }),
  [switch]$Commit,
  [switch]$Push,
  [string]$Message = '',
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$src = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if (-not (Test-Path (Join-Path $src 'package.json'))) {
  throw "source desktop not found: $src"
}
if (-not (Test-Path (Join-Path $OpenDir '.git'))) {
  throw "open repo missing .git — expected public checkout at: $OpenDir"
}

# Never copy build junk / secrets / private ops notes into the public tree.
$excludeDirs = @(
  'node_modules',
  'dist-ui',
  'target',
  'gen',
  '.git'
)
$excludeFiles = @(
  '*.log',
  '.env',
  '.env.*',
  'OPENSOURCE_PUBLISH.md'
)

Write-Host "[sync] $src"
Write-Host "    -> $OpenDir"

$xd = ($excludeDirs | ForEach-Object { "/XD"; $_ })
$xf = ($excludeFiles | ForEach-Object { "/XF"; $_ })
$extra = @('/E', '/NFL', '/NDL', '/NJH', '/NJS', '/nc', '/ns', '/np')
if ($DryRun) { $extra += '/L' }

# Mirror keeps public tree aligned (deletes files removed from desktop).
# /MIR = /E + /PURGE. Protect .git by excluding it from both sides via /XD.
& robocopy $src $OpenDir @extra @xd @xf /MIR
# robocopy exit codes 0–7 are success-ish
if ($LASTEXITCODE -ge 8) {
  throw "robocopy failed with exit code $LASTEXITCODE"
}
Write-Host "[sync] files mirrored (robocopy code=$LASTEXITCODE)"

if (-not $Commit -and -not $Push) {
  Write-Host "[sync] done. Review, then re-run with -Commit -Push when ready."
  exit 0
}

Push-Location $OpenDir
try {
  git status --short
  $dirty = git status --porcelain
  if (-not $dirty) {
    Write-Host "[sync] open repo clean — nothing to commit."
  } else {
    if (-not $Message) {
      $ver = ''
      try {
        $pkg = Get-Content (Join-Path $src 'package.json') -Raw | ConvertFrom-Json
        $ver = [string]$pkg.version
      } catch {}
      $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm'
      $Message = if ($ver) { "sync: desktop $ver ($stamp)" } else { "sync: desktop shell ($stamp)" }
    }
    if ($DryRun) {
      Write-Host "[dry-run] would commit: $Message"
    } else {
      git add -A
      git commit -m $Message
      Write-Host "[sync] committed: $Message"
    }
  }

  if ($Push) {
    if ($DryRun) {
      Write-Host "[dry-run] would push gitee main + github main"
    } else {
      $remotes = git remote
      if ($remotes -match '^gitee$') {
        Write-Host "[sync] push gitee…"
        git push gitee main
      }
      if ($remotes -match '^github$') {
        Write-Host "[sync] push github…"
        git push github main
      }
      if ($remotes -match '^origin$' -and ($remotes -notmatch '^gitee$') -and ($remotes -notmatch '^github$')) {
        Write-Host "[sync] push origin…"
        git push origin main
      }
    }
  }
} finally {
  Pop-Location
}

Write-Host "[sync] OK"
