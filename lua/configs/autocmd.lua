-- autoupdate plugins
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup("autoupdate"),
	callback = function()
		vim.defer_fn(function()
			if require("lazy.status").has_updates then
				require("lazy").update({
					show = false,
					-- Called when a plugin is updated
					on_updated = function(plugin)
						vim.api.nvim_echo({ { "Updating plugin: " .. plugin.name, "InfoMsg" } }, true, {})
					end,
				})
			end
		end, 10000)
	end,
})

-- Disable automatic commenting on newline
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})

-- Ensure window separators stay visible even after colorscheme changes.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("win_separator"),
	callback = function()
		vim.api.nvim_set_hl(0, "WinSeparator", { link = "LineNr" })
		vim.api.nvim_set_hl(0, "VertSplit", { link = "WinSeparator" })
	end,
})
