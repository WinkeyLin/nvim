-- ====== Appearance ======
-- 显示行号
vim.o.number = true
-- 显示相对行号
vim.o.relativenumber = true
-- 高亮所在行
vim.o.cursorline = true
-- 开启真彩色支持
vim.o.termguicolors = true

-- ====== Coding ======
-- translate all <Tab> to spaces
vim.o.expandtab = true
-- 智能 Tab
vim.o.smarttab = true
-- Tab 缩进 2 个空格
vim.o.tabstop = 2

-- 新行自动缩进
vim.o.autoindent = true
-- 智能缩进
vim.o.smartindent = true
-- change the indent width
vim.o.shiftwidth = 2

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"

-- 开启文件类型检测和缩进
vim.cmd("filetype indent on")
-- 语法高亮
vim.cmd("syntax on")

-- ====== Misc ======
-- 鼠标支持
vim.o.mouse = "a"
-- 当文件被外部程序修改时自动加载
vim.o.autoread = true
-- 禁用原生状态栏
vim.o.showmode = false
-- 禁用交换文件
vim.o.swapfile = false

-- ====== Clipboard ======
-- https://www.sxrhhh.top/blog/2024/06/06/neovim-copy-anywhere

vim.o.clipboard = "unnamedplus"

local function paste(reg)
	-- 返回寄存器的内容，用来作为 p 操作符的粘贴物
	return function(lines)
		local content = vim.fn.getreg('"')
		return vim.split(content, "\n")
	end
end

-- 如果是 SSH 环境，使用 OSC-52 协议传输剪贴板
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
