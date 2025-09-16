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
					-- 当某个插件更新时调用
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

