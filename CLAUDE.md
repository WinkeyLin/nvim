# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Neovim IDE configuration** (nekoVim) written entirely in Lua, using **Lazy.nvim** as the plugin manager. Targets **Neovim 0.11+** APIs. It provides a full-featured development environment with LSP, completion, formatting, Git integration, Copilot AI, terminal, file explorer, and theming.

Repository: `git@github.com:WinkeyLin/nvim.git`

## Architecture

Entry point `init.lua` loads four core modules in order:

```
init.lua
├── configs.options    -- Editor settings (indentation, line numbers, clipboard)
├── configs.keymap     -- All keybindings (100+ mappings, leader = <space>)
├── configs.plugins    -- Lazy.nvim bootstrap and plugin loader
│   └── imports plugins.{ui, coding, tools}
└── configs.autocmd    -- Auto-commands (plugin auto-update, comment format)
```

Plugin configs are organized into three categories under `lua/plugins/`:
- **ui/** — Theme (Catppuccin), statusline (lualine), bufferline, dashboard & git & terminal (snacks), misc UI libs
- **coding/** — LSP (mason + lspconfig + trouble), completion (blink.cmp + LuaSnip), treesitter, formatting (conform + Comment.nvim), copilot.lua, utils (gitsigns + chezmoi)
- **tools/** — File explorer (neo-tree), fuzzy finder (telescope), which-key

### Key Design Patterns

- **Plugin spec format**: Each plugin file returns a Lua table (or list of tables) following Lazy.nvim's spec format with `event`/`cmd` lazy-loading triggers.
- **Keymap architecture**: All keybindings are centralized in `configs/keymap.lua` using a `map()` wrapper. Plugin-specific keymaps (LSP, comment, trouble) are exported via `return plugins` table and consumed by plugin configs through `require("configs.keymap").lsp(bufnr)` etc.
- **Lazy loading by default**: `defaults = { lazy = true }` in Lazy.nvim setup — every plugin must declare its own loading trigger. Exceptions: treesitter (`lazy = false, priority = 1000`), plenary, and nvim-web-devicons are eagerly loaded as core dependencies.
- **LSP config pattern (Nvim 0.11+)**: Uses `vim.lsp.config("*", {...})` for shared defaults, then server-specific overrides like `vim.lsp.config("lua_ls", {...})`. Mason packages from `mason-org/*`.

## Code Conventions

- **Language**: Lua (no Vimscript)
- **Indentation**: Tabs (not spaces) — the project uses `tabstop=2` for display but actual files use tab characters
- **Comments**: English throughout
- **Variable naming**: camelCase (`lazypath`, `masonConfig`)
- **Function style**: `local function name()` for module-level functions
- **Formatter**: stylua for Lua files, prettier for JavaScript (configured in `plugins/coding/format.lua`)

## LSP Servers

Managed via Mason (`mason-org/mason.nvim` + `mason-org/mason-lspconfig.nvim`) with `ensure_installed` and `automatic_enable` both set to: `ts_ls`, `lua_ls`, `jsonls`. The `lua_ls` config treats `vim` as a global and uses `vim.env.VIMRUNTIME` for workspace library. Completion capabilities are provided by `blink.cmp` (integrated via `blink_cmp.get_lsp_capabilities()`).

## Important Files

| File | Purpose |
|------|---------|
| `lazy-lock.json` | Plugin version lockfile — do not manually edit |
| `lua/configs/keymap.lua` | Central keybinding registry; exports `plugins.lsp()`, `plugins.comment()`, `plugins.trouble()`, and `plugins.cmp()` for plugin configs to consume |
| `lua/configs/plugins.lua` | Lazy.nvim bootstrap (auto-clones if missing) and plugin directory imports |
| `lua/plugins/coding/utils.lua` | Utility plugins: gitsigns and chezmoi template support |
