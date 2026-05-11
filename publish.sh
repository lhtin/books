#!/usr/bin/env bash
set -ex

bash build.sh

git add html

# 仅当 html 有变更时才提交，避免"nothing to commit"导致脚本中断
if ! git diff --cached --quiet -- html; then
    git commit -m "build html"
else
    echo "html 无变更，跳过提交"
fi

# 将 html 子目录拆分为独立 commit，并强制推送到远端 gh-pages 分支
# 使用 force push 覆盖 gh-pages（产物分支），避免 subtree push 的 non-fast-forward 问题
SUBTREE_SHA="$(git subtree split --prefix=html HEAD)"
git push --force origin "${SUBTREE_SHA}:refs/heads/gh-pages"

git push
