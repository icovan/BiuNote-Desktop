# 已废弃：不要再复制到 E:\open\biunote-desktop。
# 开源桌面请直接：
#   cd desktop
#   powershell -File scripts/push-github.ps1
# 说明见 README.md

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $here 'push-github.ps1')
