#!/bin/bash
# 自动同步 Obsidian 真实 content 到 Hugo 项目
# 使用前请确保目标目录路径正确

# 源 content 目录（Obsidian）
SRC="/Users/allenliu/Library/Mobile Documents/iCloud~md~obsidian/Documents/xuefeng-ai"
# 目标 content 目录（Hugo 项目）
DST="/Users/allenliu/Documents/GitHub/xuefeng-ai/content"

# 如果 content 是软链接，先删除
if [ -L "$DST" ]; then
    rm "$DST"
fi

# 拷贝 Obsidian 目录为 content
cp -a "$SRC" "$DST"

echo "同步完成：已将 Obsidian 内容复制到 Hugo 项目 content 目录。"
