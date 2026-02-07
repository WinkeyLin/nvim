# nekoVim

基于 Lua 的现代 Neovim IDE 配置，使用 [Lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件，面向 **Neovim 0.11+**。

## 特性

- **补全引擎** — [blink.cmp](https://github.com/saghen/blink.cmp) + LuaSnip 代码片段
- **LSP** — Mason 自动安装与管理语言服务器（TypeScript、Lua、JSON）
- **诊断** — 行内虚拟文本 + [Trouble.nvim](https://github.com/folke/trouble.nvim) 诊断列表
- **AI 辅助** — [copilot.lua](https://github.com/zbirenbaum/copilot.lua) + CopilotChat
- **文件浏览** — [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)（窄窗口自动切换浮窗模式）
- **模糊搜索** — [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **Git 集成** — gitsigns 行标记 + Snacks lazygit / blame
- **格式化** — [conform.nvim](https://github.com/stevearc/conform.nvim)（Lua → stylua，JS → prettier）+ 保存时自动格式化
- **主题** — [Catppuccin](https://github.com/catppuccin/nvim)（支持 `<leader>tt` 切换亮/暗色）
- **其他** — 缩进动画、集成终端、仪表板、右键菜单、nvim-surround

## 安装

```bash
# 备份已有配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆仓库
git clone git@github.com:WinkeyLin/nvim.git ~/.config/nvim
```

首次启动 Neovim 时 Lazy.nvim 会自动引导安装并拉取所有插件。

## 目录结构

```
init.lua                    -- 入口，按序加载四个核心模块
lua/
├── configs/
│   ├── options.lua         -- 编辑器设置（缩进、行号、剪贴板等）
│   ├── keymap.lua          -- 所有快捷键定义（Leader = Space）
│   ├── plugins.lua         -- Lazy.nvim 引导与插件目录导入
│   └── autocmd.lua         -- 自动命令（插件自动更新、注释格式）
└── plugins/
    ├── ui/                 -- 主题、状态栏、标签栏、仪表板、通知
    ├── coding/             -- LSP、补全、语法高亮、格式化、Copilot
    └── tools/              -- 文件浏览器、模糊搜索、快捷键提示
```

## 快捷键

Leader 键为 `Space`。完整定义见 `lua/configs/keymap.lua`，以下列出常用快捷键。

### 编辑器

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+S` | 保存文件 |
| `Ctrl+Z` / `Ctrl+Y` | 撤销 / 重做 |
| `Ctrl+A` | 全选 |
| `Ctrl+/` | 切换注释 |
| `J` / `K`（可视模式） | 上下移动选中行 |

### 窗口管理

| 快捷键 | 功能 |
|--------|------|
| `<leader>sv` / `<leader>sh` | 垂直 / 水平分屏 |
| `<leader>cw` / `<leader>co` | 关闭当前 / 其他窗口 |
| `Alt+H/J/K/L` | 在窗口间跳转 |
| `Alt+S + 方向键` | 调整窗口大小 |

### 文件与搜索

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+P` / `<leader>ff` | 查找文件 |
| `Shift+F` / `<leader>fw` | 全局搜索 |
| `Ctrl+H` / `<leader>fr` | 最近文件 |
| `Alt+T` / `<leader>tr` | 切换文件树 |

### 标签页（Buffer）

| 快捷键 | 功能 |
|--------|------|
| `Alt+Tab` | 下一个 Buffer |
| `Shift+Tab` | 上一个 Buffer |
| `Ctrl+W` | 关闭 Buffer |

### LSP

| 快捷键 | 功能 |
|--------|------|
| `<leader>gd` | 跳转到定义 |
| `<leader>gr` | 查看引用 |
| `<leader>gh` | 悬浮文档 |
| `<leader>rn` | 重命名符号 |
| `<leader>ca` | 代码操作 |
| `<leader>go` / `gp` / `gn` | 诊断浮窗 / 上一个 / 下一个 |

### 诊断（Trouble）

| 快捷键 | 功能 |
|--------|------|
| `<leader>xx` | 全部诊断 |
| `<leader>xX` | 当前 Buffer 诊断 |
| `<leader>xs` | 符号列表 |
| `<leader>xq` | Quickfix 列表 |

### 工具

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+\` / `<leader>te` | 切换终端 |
| `<leader>gt` | 打开 Lazygit |
| `<leader>gb` | Git Blame 当前行 |
| `<leader>cp` | 切换 Copilot Chat |
| `<leader>tt` | 切换亮/暗主题 |
| `<leader>fm` | 格式化代码 |
| `<leader>wk` | 查看所有快捷键（WhichKey） |

## LSP 服务器

通过 [Mason](https://github.com/mason-org/mason.nvim) 自动安装和管理：

| 服务器 | 语言 |
|--------|------|
| `ts_ls` | TypeScript / JavaScript |
| `lua_ls` | Lua（已预配置 Neovim runtime 全局变量） |
| `jsonls` | JSON |

## 许可

MIT
