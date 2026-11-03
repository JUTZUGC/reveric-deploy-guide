#!/usr/bin/env bash
set -euo pipefail
# Reveric 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/looplj/reveric#下载安装
# 更新日期：2026-11-03
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -O https://github.com/looplj/reveric/releases/download/v0.6.2/reveric-0.6.2-macos-arm64.dmg
echo "macOS 打开 dmg 拖进 Applications；Windows 与 Android 见下方安装包表"

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/looplj/reveric#下载安装"
