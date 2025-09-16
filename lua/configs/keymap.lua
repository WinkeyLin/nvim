-- wait 300ms before triggering keymap
vim.o.timeoutlen = 300

-- set Leader key
vim.g.mapleader = " "

local function map(key, mapKey, desc, modeOverride, optsOverride)
	local mode = modeOverride and modeOverride or "n"
	local opts = optsOverride and optsOverride or { noremap = true, silent = true }
	opts["desc"] = desc
	vim.keymap.set(mode, key, mapKey, opts)
end

-- ====== editor ======

-- Ctrl + A select all
map("<C-a>", "gg0vG$", "Select All")
-- Ctrl + Z undo
map("<C-z>", "u", "Undo")
map("<C-z>", "<C-o>u", "Undo", "i")
-- Ctrl + Y redo
map("<C-y>", "<C-r>", "Redo")
map("<C-y>", "<C-o><C-r>", "Redo", "i")
-- Ctrl +S save file
map("<C-s>", "<cmd>w<CR>", "Save File")
-- Ctrl + / toggle Comment
map("<C-_>", "gcc", "Toggle Line Comment", { "i", "n" })
map("<C-_>", "<C-o>gcc", "Toggle Line Comment", { "i", "n" })
map("<C-_>", "gbc", "Toggle Block Comment", "v")
-- 上下移动选中文本
map("J", ":move '>+1<CR>gv-gv", "Move Up Selected Text", "v")
map("K", ":move '<-2<CR>gv-gv", "Move Down Selected Text", "v")
-- === windows split ===
-- 水平分屏
map("<leader>sv", ":vsp<CR>", "Split Window Vertically")
-- 垂直分屏
map("<leader>sh", ":sp<CR>", "Split Window Horizontally")
-- 关闭当前
map("<leader>sw", "<C-w>c", "Close Current Window")
-- 关闭其他
map("<leader>sc", "<C-w>o", "Close Other Windows")
-- Alt + hjkl  窗口之间跳转
map("<A-h>", "<C-w>h", "Jump to Left Window")
map("<A-j>", "<C-w>j", "Jump to Down Window")
map("<A-k>", "<C-w>k", "Jump to Up Window")
map("<A-l>", "<C-w>l", "Jump to Right Window")
-- 调整左右比例
map("<A-s><Right>", ":vertical resize +20<CR>", "Increase Window Width")
map("<A-s><Left>", ":vertical resize -20<CR>", "Decrease Window Width")
-- 调整上下比例
map("<A-s><Up>", ":resize +5<CR>", "Increase Window Height")
map("<A-s><Down>", ":resize -5<CR>", "Decrease Window Height")
-- 各窗口等比例显示
map("<A-s>=", "<C-w>=", "Equalize Window Size")
-- 切换主题
map("<leader>tt", function()
	local light = "catppuccin-latte"
	local dark = "catppuccin-macchiato"
	if vim.g.colors_name == light then
		vim.cmd("colorscheme " .. dark)
	else
		vim.cmd("colorscheme " .. light)
	end
end, "Toggle Theme")

-- ====== plugins ======

-- === nvimtree ===
map("<A-t>", "<cmd>NvimTreeToggle<CR>", "toggle nvimtree")
map("<leader>tr", "<cmd>NvimTreeToggle<CR>", "toggle nvimtree")

-- === whichkey ===
map("<leader>wk", "<cmd>WhichKey <CR>", "whichkey all keymaps")
map("<leader>wkq", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, "whichkey query lookup")

-- === telescope ===
-- Find Files
map("<C-p>", ":Telescope find_files<CR>", "Telescope Find Files")
map("<leader>ff", ":Telescope find_files<CR>", "Telescope Find Files")
-- Global Search
map("<S-f>", ":Telescope live_grep<CR>", "Telescope Live Grep")
map("<leader>fw", ":Telescope live_grep<CR>", "Telescope Live Grep")
-- Recent File
map("<C-h>", ":Telescope oldfiles<CR>", "Telescope Old Files")
map("<leader>fr", ":Telescope oldfiles<CR>", "Telescope Old Files")

-- === bufferline ===
-- next tab
map("<A-tab>", "<cmd>BufferLineCycleNext<CR>", "Next Buffer")
-- prev tab
map("<S-tab>", "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer")
-- close tab
map("<C-w>", ":bdelete!<CR>", "Close Buffer")

-- === copilot ===
-- toggle copilot chat
map("<leader>cp", ":CopilotChatToggle<CR>", "Toggle Copilot Chat")
-- next copilot suggestion
map("<A-]>", "<Plug>(copilot-next)", "Next Copilot Suggestion", "i")
-- prev copilot suggestion
map("<A-[>", "<Plug>(copilot-prev)", "Previous Copilot Suggestion", "i")

-- === Snacks ===
-- Notifier History
map("<leader>nh", "<cmd>lua Snacks.notifier.show_history()<CR>", "Show Notifier History")
-- Toggle Terminal
map("<C-\\>", "<cmd>lua Snacks.terminal.toggle()<CR>", "Toggle Terminal")
map("<leader>te", "<cmd>lua Snacks.terminal.toggle()<CR>", "Toggle Terminal")

-- === conform ===
map("<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, "Format Code")

-- === right-click menu ===
-- for keyboard
map("<A-m>", function()
	require("menu").open("default")
end, "Open Right-Click Menu")
-- for mouse & nvimtree
map("<RightMouse>", function()
	require("menu.utils").delete_old_menus()
	vim.cmd.exec('"normal! \\<RightMouse>"')
	-- clicked buf
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options, { mouse = true })
end, "Open Right-Click Menu")

-- ====== Plugins keymap ======
local plugins = {}

-- lsp
plugins.lsp = function(bufnr)
	local optLSP = { noremap = true, silent = true, buffer = bufnr }
	-- rename
	map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol", "n", optLSP)
	-- code action
	map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action", "n", optLSP)
	-- jump
	map("<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition", "n", optLSP)
	map("<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation", "n", optLSP)
	map("<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration", "n", optLSP)
	map("<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation", "n", optLSP)
	map("<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go to References", "n", optLSP)
	-- diagnostic
	map("<leader>go", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Diagnostic Float", "n", optLSP)
	map("<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to Previous Diagnostic", "n", optLSP)
	map("<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to Next Diagnostic", "n", optLSP)
end

-- cmp
-- 需要同时设置在插入模式 i 和 命令行模式 c 下生效
plugins.cmp = function(cmp)
	return {
		["<C-Space>"] = cmp.mapping.complete(),
		["<Esc>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<CR>"] = {
			i = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
		},
		["Tab"] = {
			c = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
		},
	}
end

return plugins
