-- https://github.com/nvim-lualine/lualine.nvim

local function getIconFilename()
	local filename = vim.fn.expand("%:t")
	if filename == "" then
		filename = "New File"
	end
	local icon = "󰈚"
	local filetype = vim.bo.filetype
		if filetype ~= "" then
			local devicon = require("nvim-web-devicons").get_icon(filename, filetype)
			icon = devicon or icon
		end
		-- Add modified-status indicator
		local status = vim.bo.modified and " " or ""
		return string.format("%s %s%s", icon, filename, status)
	end

local function getLspInfo()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		names[#names + 1] = client.name
	end
	return table.concat(names, ", ")
	end

	local function getDir()
		-- Get current working directory
		local cwd = vim.uv.cwd()
		-- Get directory name
		return cwd:match("([^/\\]+)[/\\]*$") or cwd
	end

	-- Show current line/total lines:column
	local function getPosition()
		local line = vim.fn.line(".")
		local col = vim.fn.col(".")
		local totalLines = vim.fn.line("$")
	local progress = function()
		if line == 1 then
			return "TOP"
		elseif line == totalLines then
			return "BOT"
		else
			return string.format("%d%%%%", math.ceil((line / totalLines) * 100))
		end
	end
	if vim.api.nvim_win_get_width(0) > 30 then
		return string.format(" %d:%d   %s %d", line, col, progress(), totalLines)
	else
		return string.format(" %d:%d", line, col)
	end
end

local config = {
	options = {
		theme = "catppuccin",
		disabled_filetypes = { "neo-tree" },
		extensions = { "neo-tree" },
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		highlight_options = { bold = false },
	},
	sections = {
		lualine_a = { { "mode", padding = { left = 1, right = 0 } } },
		lualine_b = {
			{
					getIconFilename,
					padding = { left = 1, right = 0 },
					on_click = function()
						vim.cmd("Neotree toggle")
					end,
					cond = function ()
						return vim.api.nvim_win_get_width(0) > 70
					end,
			},
		},
		lualine_c = { "branch" },
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				symbols = { error = "󰅙 ", warn = " ", info = "󰋼 ", hint = "󰌵 " },
				update_in_insert = true,
			},
			getLspInfo,
		},
		lualine_y = {
			{
				getDir,
				icon = "",
				cond = function ()
					return vim.api.nvim_win_get_width(0) > 70
				end,
			},
		},
		lualine_z = { { getPosition, padding = { left = 0, right = 1 } } },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	priority = 300,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup(config)
	end,
}
