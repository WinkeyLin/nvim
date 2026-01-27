-- ====== Appearance ======
-- Show line numbers
vim.o.number = true
-- Show relative line numbers
vim.o.relativenumber = true
-- Highlight the current line
vim.o.cursorline = true
-- Enable true color support
vim.o.termguicolors = true

-- ====== Coding ======
-- translate all <Tab> to spaces
vim.o.expandtab = true
-- Smart Tab
vim.o.smarttab = true
-- Tab width: 2 spaces
vim.o.tabstop = 2

-- Auto-indent new lines
vim.o.autoindent = true
-- Smart indent
vim.o.smartindent = true
-- change the indent width
vim.o.shiftwidth = 2

-- Case-insensitive search unless the pattern contains uppercase
vim.o.ignorecase = true
vim.o.smartcase = true
-- Allow <Left>/<Right> to wrap to the previous/next line
vim.o.whichwrap = "<,>,[,]"

-- ====== Misc ======
-- Enable mouse support
vim.o.mouse = "a"
-- Open new vertical splits to the right and horizontal splits below
vim.o.splitright = true
vim.o.splitbelow = true
-- Prefer using already open windows and tabs when switching buffers
vim.o.switchbuf = "useopen,usetab"
-- Auto-reload files changed outside of Neovim
vim.o.autoread = true
-- Disable the built-in mode indicator (use statusline instead)
vim.o.showmode = false
-- Disable swap files
vim.o.swapfile = false

-- Show a clear vertical separator between windows (e.g. neo-tree and editor)
vim.opt.fillchars:append({ vert = "│" })

-- ====== Clipboard ======
-- https://www.sxrhhh.top/blog/2024/06/06/neovim-copy-anywhere

vim.o.clipboard = "unnamedplus"

local function paste(reg)
	-- Return the register content to use as the pasted text for the `p` operator
	return function()
		local content = vim.fn.getreg(reg)
		return vim.split(content, "\n")
	end
end

-- In an SSH session, use the OSC52 protocol to access the clipboard
if os.getenv("SSH_TTY") then
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste("+"),
			["*"] = paste("*"),
		},
	}
end
