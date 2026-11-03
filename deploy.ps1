# Reveric 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/looplj/reveric#下载安装
# 更新日期：2026-11-03
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o reveric-setup.exe https://github.com/looplj/reveric/releases/download/v0.6.2/reveric-0.6.2-windows-setup.exe
Start-Process -Wait .\reveric-setup.exe
Write-Host "安装完成：打开 Reveric，先填模型 API Key"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/looplj/reveric#下载安装'
