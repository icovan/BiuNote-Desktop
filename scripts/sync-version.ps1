# Sync desktop package versions from configs/config.yaml (app.version).
# Optionally copy built exe to BiuNote-Vx.x.x.exe
param(
  [switch]$RenameExe,
  [string]$ExePath = ''
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$cfgPath = Join-Path $root 'configs\config.yaml'
if (-not (Test-Path $cfgPath)) { throw "missing $cfgPath" }

$raw = Get-Content $cfgPath -Raw
if ($raw -notmatch '(?m)^\s*version:\s*"?([^"\r\n]+)"?') {
  throw "app.version not found in config.yaml"
}
$ver = $Matches[1].Trim().Trim('"')
$ver = $ver -replace '^v', ''
if (-not $ver) { throw "empty app.version" }

Write-Host "Sync desktop version -> $ver"
$utf8 = New-Object System.Text.UTF8Encoding $false

function Set-JsonVersion([string]$path) {
  $text = [System.IO.File]::ReadAllText($path)
  $next = [regex]::Replace($text, '("version"\s*:\s*")[^"]*(")', "`${1}$ver`${2}", 1)
  [System.IO.File]::WriteAllText($path, $next, $utf8)
}

Set-JsonVersion (Join-Path $root 'desktop\package.json')
Set-JsonVersion (Join-Path $root 'desktop\src-tauri\tauri.conf.json')

$cargoPath = Join-Path $root 'desktop\src-tauri\Cargo.toml'
$cargo = [System.IO.File]::ReadAllText($cargoPath)
$cargo2 = [regex]::Replace($cargo, '(?m)^version\s*=\s*"[^"]+"', "version = `"$ver`"", 1)
[System.IO.File]::WriteAllText($cargoPath, $cargo2, $utf8)

if (-not $RenameExe) { return }

$candidates = @()
if ($ExePath) {
  $candidates += $ExePath
} else {
  $candidates += (Join-Path $root 'desktop\src-tauri\target\release\BiuNote.exe')
  $candidates += (Join-Path $root 'desktop\src-tauri\target\release\biunote.exe')
}
$src = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $src) { throw "built exe not found; pass -ExePath" }
$destDir = Split-Path $src -Parent
$dest = Join-Path $destDir ("BiuNote-V$ver.exe")
Copy-Item -Path $src -Destination $dest -Force
Write-Host "Copied -> $dest"
