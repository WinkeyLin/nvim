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
map("<C-s>", "<cmd>w<CR>", "Save File", { "n", "v" })
map("<C-s>", "<C-o>:w<CR>", "Save File", "i")
-- Move selected text up/down
map("J", ":move '>+1<CR>gv-gv", "Move Up Selected Text", "v")
map("K", ":move '<-2<CR>gv-gv", "Move Down Selected Text", "v")
-- === windows split ===
-- Vertical split
map("<leader>sv", ":vsp<CR>", "Split Window Vertically")
-- Horizontal split
map("<leader>sh", ":sp<CR>", "Split Window Horizontally")
-- Close current window
map("<leader>cw", "<C-w>c", "Close Current Window")
-- Close other windows
map("<leader>co", "<C-w>o", "Close Other Windows")
-- Alt + hjkl: move between windows
map("<A-h>", "<C-w>h", "Jump to Left Window")
map("<A-j>", "<C-w>j", "Jump to Down Window")
map("<A-k>", "<C-w>k", "Jump to Up Window")
map("<A-l>", "<C-w>l", "Jump to Right Window")
-- Resize window width
map("<A-s><Right>", ":vertical resize +20<CR>", "Increase Window Width")
map("<A-s><Left>", ":vertical resize -20<CR>", "Decrease Window Width")
-- Resize window height
map("<A-s><Up>", ":resize +5<CR>", "Increase Window Height")
map("<A-s><Down>", ":resize -5<CR>", "Decrease Window Height")
-- Equalize window sizes
map("<A-s>=", "<C-w>=", "Equalize Window Size")
-- Toggle theme
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

-- === neo-tree ===
local function toggleFileTree()
	if vim.api.nvim_win_get_width(0) > 70 then
		vim.cmd("Neotree toggle")
	else
		vim.cmd("Neotree float")
	end
end
map("<A-t>", toggleFileTree, "Toggle File Tree")
map("<leader>tr", toggleFileTree, "Toggle File Tree")

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
-- close tab (use Snacks.bufdelete to preserve window layout)
map("<C-w>", function()
	Snacks.bufdelete()
end, "Close Buffer")

-- === copilot ===
-- toggle copilot chat
map("<leader>cp", ":CopilotChatToggle<CR>", "Toggle Copilot Chat")
-- next/prev copilot suggestion (copilot.lua)
map("<A-]>", function()
	local ok, suggestion = pcall(require, "copilot.suggestion")
	if ok then
		suggestion.next()
	end
end, "Next Copilot Suggestion", "i")
map("<A-[>", function()
	local ok, suggestion = pcall(require, "copilot.suggestion")
	if ok then
		suggestion.prev()
	end
end, "Previous Copilot Suggestion", "i")

-- === Snacks ===
-- Notifier History
map("<leader>nh", "<cmd>lua Snacks.notifier.show_history()<CR>", "Show Notifier History")
-- Toggle Terminal
map("<C-\\>", "<cmd>lua Snacks.terminal.toggle()<CR>", "Toggle Terminal")
map("<leader>te", "<cmd>lua Snacks.terminal.toggle()<CR>", "Toggle Terminal")
-- Git
map("<leader>gt", "<cmd>lua Snacks.lazygit()<CR>", "Open Lazygit")
map("<leader>gb", "<cmd>lua Snacks.git.blame_line()<CR>", "Git Blame Line")

-- === conform ===
map("<leader>fm", function()
	require("conform").format({ lsp_format = "fallback" })
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
	-- keep a safe default for neo-tree (menu.nvim has a built-in nvimtree menu, but not neo-tree)
	local options = "default"
	require("menu").open(options, { mouse = true })
end, "Open Right-Click Menu")

-- ====== Plugins keymap ======
local plugins = {}

-- comment (Comment.nvim)
plugins.comment = function()
	local api = require("Comment.api")
	-- normal mode: toggle current line
	map("<C-/>", function()
		api.toggle.linewise.current()
	end, "Toggle Comment", "n")
	-- visual mode: toggle selected block
	map("<C-/>", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
		api.toggle.linewise(vim.fn.visualmode())
	end, "Toggle Comment", "v")
	-- insert mode: toggle current line
	map("<C-/>", function()
		api.toggle.linewise.current()
	end, "Toggle Comment", "i")
end

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
	map("<leader>gp", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<CR>", "Go to Previous Diagnostic", "n", optLSP)
	map("<leader>gn", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<CR>", "Go to Next Diagnostic", "n", optLSP)
end

-- trouble
plugins.trouble = function()
	map("<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", "Diagnostics (Trouble)")
	map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Buffer Diagnostics (Trouble)")
	map("<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", "Symbols (Trouble)")
	map("<leader>xq", "<cmd>Trouble qflist toggle<CR>", "Quickfix List (Trouble)")
end

-- trouble
plugins.trouble = function()
	map("<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", "Diagnostics (Trouble)")
	map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Buffer Diagnostics (Trouble)")
	map("<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", "Symbols (Trouble)")
	map("<leader>xq", "<cmd>Trouble qflist toggle<CR>", "Quickfix List (Trouble)")
end

-- cmp
-- Needs to be set for both insert (i) and command-line (c) modes
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
