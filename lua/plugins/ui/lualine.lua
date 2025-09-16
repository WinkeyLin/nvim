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
	-- 添加修改状态指示
	local status = vim.bo.modified and " " or ""
	return string.format("%s %s%s", icon, filename, status)
end

local function getLspInfo()
	local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
	local clients = vim.lsp.get_clients()
	if next(clients) == nil then
		return ""
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return ""
end

local function getDir()
	-- 获取当前工作目录路径
	local cwd = vim.uv.cwd()
	-- 获取目录名
	return cwd:match("([^/\\]+)[/\\]*$") or cwd
end

-- 显示当前光标所在的行号/总行数:列号
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
		disabled_filetypes = { "NvimTree" },
		extensions = { "nvim-tree" },
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
				on_clink = function()
					vim.cmd("NvimTreeToggle<CR>")
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
