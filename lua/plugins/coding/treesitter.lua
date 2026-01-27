-- https://github.com/nvim-treesitter/nvim-treesitter

local config = {
	auto_install = true,
	ensure_installed = { "lua", "json", "javascript", "typescript", "python", "tsx", "vim" },
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	-- Indentation module; `=` indents the selected code
	indent = { enable = true },
	-- Incremental selection module
	incremental_selection = {
		enable = true,
		keymaps = {
			-- Enter: expand selection
			init_selection = "<CR>",
			node_incremental = "<CR>",
			-- Backspace: shrink selection
			node_decremental = "<BS>",
			-- Tab: expand to the next scope
			scope_incremental = "<TAB>",
		},
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	priority = 1000,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	opts = config,
	config = function()
		require("nvim-treesitter.configs").setup(config)
	end,
}
