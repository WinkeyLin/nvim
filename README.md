# nekoVim Configuration

Kanro's Neovim setup powered by `lazy.nvim`, focused on fast startup, clean UI, modern LSP workflow, and practical editing defaults.

## Requirements

- Neovim `>= 0.11` (this config uses `vim.lsp.config()` APIs)
- `git`
- A Nerd Font (for icons in statusline/file tree)
- Optional but recommended:
  - `ripgrep` for `Telescope live_grep`
  - `stylua` for Lua formatting
  - `prettier` for JavaScript formatting
  - `lazygit` for Git UI integration

## Installation

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone <your-repo-url> ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` is bootstrapped automatically and plugins are installed.

## Structure

```text
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── configs
    │   ├── autocmd.lua
    │   ├── keymap.lua
    │   ├── options.lua
    │   └── plugins.lua
    └── plugins
        ├── coding
        ├── tools
        └── ui
```

## Core Features

- Plugin management with `folke/lazy.nvim`
- Theme: `catppuccin`
- Completion: `saghen/blink.cmp` + `LuaSnip` + `nvim-autopairs`
- LSP: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`
- Diagnostics list: `folke/trouble.nvim`
- Syntax/folding/indent: `nvim-treesitter`
- File explorer: `neo-tree.nvim`
- Fuzzy finder: `telescope.nvim`
- Statusline/tabline: `lualine.nvim` + `bufferline.nvim`
- Utility UI: `snacks.nvim`, `which-key.nvim`
- Git helpers: `gitsigns.nvim`, `Snacks.lazygit()`, inline blame
- AI workflow: `copilot.lua` + `CopilotChat.nvim`

## Default LSP and Formatter Setup

- Auto-installed LSP servers:
  - `ts_ls`
  - `lua_ls`
  - `jsonls`
- Formatting (`conform.nvim`):
  - Lua: `stylua`
  - JavaScript: `prettier`
  - LSP fallback enabled on save

## Keymaps (Selected)

- File tree:
  - `<A-t>` or `<leader>tr`: toggle Neo-tree
- Search:
  - `<C-p>` / `<leader>ff`: find files
  - `<S-f>` / `<leader>fw`: live grep
  - `<C-h>` / `<leader>fr`: recent files
- Window and buffers:
  - `<leader>sv`: vertical split
  - `<leader>sh`: horizontal split
  - `<leader>cw`: close current window
  - `<leader>co`: close other windows
  - `<A-tab>` / `<S-tab>`: next/previous buffer
  - `<C-w>`: close current buffer (via `Snacks.bufdelete`)
- Editing:
  - `<C-s>`: save
  - `<leader>fm`: format buffer
  - `<C-/>`: toggle comment
- LSP and diagnostics:
  - `<leader>gd`: go to definition
  - `<leader>gr`: references
  - `<leader>rn`: rename
  - `<leader>ca`: code action
  - `<leader>xx`: diagnostics list (`Trouble`)
- Terminal and Git:
  - `<C-\>` / `<leader>te`: toggle terminal
  - `<leader>gt`: open Lazygit
  - `<leader>gb`: blame current line
- AI:
  - `<leader>cp`: toggle Copilot Chat
- Appearance:
  - `<leader>tt`: toggle Catppuccin light/dark flavor

## Notes

- Plugins are auto-checked for updates on startup.
- Clipboard over SSH is handled through OSC52 fallback.
- Window separators are explicitly highlighted after colorscheme changes.
