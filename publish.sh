#!/bin/bash
# 一键发布脚本，自动提交 content 目录内容并推送到 GitHub，然后触发 Vercel 生产部署

echo "正在将 content 目录的更改推送到 GitHub..."
git add content

# 获取 commit 消息，如果用户在运行脚本时提供了参数，则使用该参数作为 commit 消息
# 否则，使用默认消息 "chore: 更新内容"
commit_message="${1:-chore: 更新内容}"
git commit -m "$commit_message"

if git push origin master; then
  echo "内容已成功推送到 GitHub。"
  echo ""
  echo "正在触发 Vercel 生产环境部署..."
  echo "请确保您已安装 Vercel CLI 并已登录 (npm install -g vercel && vercel login)"
  echo "或者您的 Vercel 项目已配置为自动从 master 分支部署到生产环境。"
  
  # 尝试使用 Vercel CLI 部署到生产环境
  # 如果 Vercel CLI 不存在或未登录，此步骤可能会失败或提示
  if command -v vercel &> /dev/null; then
    vercel --prod
    echo "Vercel 生产部署已触发。请访问您的 Vercel 控制台查看部署状态。"
  else
    echo "警告：未找到 Vercel CLI 命令。如果您希望脚本自动触发部署，请安装并登录 Vercel CLI。"
    echo "如果 Vercel 已配置为从 GitHub 自动部署，则无需额外操作。"
  fi
else
  echo "错误：推送到 GitHub 失败。Vercel 部署未触发。"
  exit 1
fi

echo ""
echo "发布脚本执行完毕。" 