-- Bootstrap lazy.nvim
-- define lazypath as path to lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- clone lazy.nvim if not installed
if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

-- add lazy.nvim path to runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import lua configs under "plugins" dir
		{ import = "plugins.ui" },
		{ import = "plugins.coding" },
		{ import = "plugins.tools" },
	},
	-- enable lazy loading by default
	defaults = { lazy = true },
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin-frappe" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
	-- enable cache
	performance = {
		cache = {
			enabled = true,
		},
	},
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
})

