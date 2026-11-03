# Reveric 一键安装指南

> 第三方部署指南 · 非 Reveric 官方仓库。官方项目：[looplj/reveric](https://github.com/looplj/reveric)
> 内容来自官方文档（2026-11-03）。项目迭代快，请以[官方文档](https://github.com/looplj/reveric#下载安装)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把安装包下载并校验好。

⚠️ 桌面应用，提供 Windows 安装包、macOS 包与 Android APK。需要自备模型 API Key（Anthropic、OpenAI 等），按量计费。作品、设定与工程都存在本地 SQLite 与文件夹，升级覆盖安装不会丢。AGPL-3.0，二次分发前先读许可证。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/reveric-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会下载 Windows 安装包并启动向导，数据默认落在本机，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Reveric 是什么？

Reveric 是开源的把长篇小说的设定、文风与分集剧本收进一个本地工作台（协议：AGPL-3.0，<img src="https://img.shields.io/github/stars/looplj/reveric?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

面向长篇小说与短剧的 AI 创作工作台：管理设定与文风规则，生成分集剧本与对白，支持技能扩展与多模型切换，全部在本机运行。

- 长篇小说与短剧两种工作流
- 设定、文风与禁忌可写成长期规则
- 多模型：Anthropic、OpenAI 等
- 数据本地 SQLite，升级不丢
- 支持技能扩展
- AGPL-3.0，可审可改

（来源：[官方仓库](https://github.com/looplj/reveric)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 563 stars | 名称搜索仅 4 条结果 |
| 小说与短剧两条工作流 | — |
| 设定与文风可长期复用 | — |
| 数据留本机 | — |
| Windows/macOS/Android 都有包 | — |
| AGPL-3.0 | 可审可改 |

| 需要注意 | 说明 |
|---|---|
| 需要自备模型 Key | — |
| 长文本受上下文限制 | — |
| Android 版功能可能不全 | — |
| AGPL-3.0 | 商用需注意 |
| 项目很新 | 工程格式可能变 |

> 以上基于官方文档与社区反馈整理（2026-11-03），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -O https://github.com/looplj/reveric/releases/download/v0.6.2/reveric-0.6.2-macos-arm64.dmg
echo "macOS 打开 dmg 拖进 Applications；Windows 与 Android 见下方安装包表"
```

安装包来源：[https://github.com/looplj/reveric#下载安装](https://github.com/looplj/reveric#下载安装)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认三平台安装包、本地 SQLite 与模型要求 | 已核对 2026-11-03 |
| 未实测安装与创作流程 | 说明 2026-11-03 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-03 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-03 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、模型配置与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-03）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\reveric-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装包

| 平台 | 文件 |
|---|---|
| Windows 10/11 x64 | `reveric-0.6.2-windows-setup.exe` |
| macOS Apple Silicon | `reveric-0.6.2-macos-arm64.dmg` |
| Android arm64 | `reveric-android-arm64-v8a-v0.6.2.apk` |

## 第一次使用

1. 安装后打开，填模型 API Key
2. 新建小说或短剧工程
3. 写设定、文风与禁忌规则
4. 按分集生成剧本与对白

## 数据在哪

工程、设定与历史都存在本机 SQLite 与工程目录；升级直接覆盖安装即可。

## 注意

- 模型费用按 token 计，先设预算
- 长篇小说建议分卷，单次上下文有限
- 规则写得越具体，风格越稳定
- Android 版功能可能与桌面版有差异
- AGPL-3.0，分发前先读条款

## 常见坑

- 安装被拦：核对来源后放行 SmartScreen 或 Gatekeeper
- 模型报错：检查 Key、余额与模型名
- 生成中断：缩短单次章节，分卷处理
- 数据找不到：确认没有移动本地工程目录
- 升级后打不开旧工程：先备份工程目录再升级
- Android 装不上：确认 arm64 架构与系统版本

## 免责声明

本仓库为第三方指南，与 Reveric 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-03），项目迭代快，请以[官方文档](https://github.com/looplj/reveric#下载安装)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
