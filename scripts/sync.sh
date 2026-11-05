#!/usr/bin/env bash
# 同步 AI 大脑：拉取远端更新，推送本地变更
set -euo pipefail

cd "$(dirname "$0")/.."

branch="$(git rev-parse --abbrev-ref HEAD)"
git pull --rebase origin "$branch"

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "memory: sync from $(hostname) at $(date '+%Y-%m-%d %H:%M')"
  git push origin "$branch"
fi

echo "✅ 大脑已同步"
