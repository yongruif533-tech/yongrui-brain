# 同步 AI 大脑：拉取远端更新，推送本地变更
# 用法：powershell -ExecutionPolicy Bypass -File scripts/sync.ps1

$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

$branch = git rev-parse --abbrev-ref HEAD
git pull --rebase origin $branch

$changes = git status --porcelain
if ($changes) {
    git add -A
    $msg = "memory: sync from $env:COMPUTERNAME at $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git commit -m $msg
    git push origin $branch
}

Write-Host "✅ 大脑已同步"
