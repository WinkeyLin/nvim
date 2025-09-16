-- https://github.com/folke/snacks.nvim

-- 判断窗口宽度是否大于 70
local isWide = vim.api.nvim_win_get_width(0) > 70

local dbConfig = {
	enabled = true,
	width = 35,
	row = nil, -- dashboard position. nil for center
	col = nil, -- dashboard position. nil for center
	pane_gap = 3, -- empty columns between vertical panes
	preset = {
		keys = {
			{ icon = "󱪞 ", desc = "New File", key = "n", action = ":ene | startinsert" },
			{ icon = " ", desc = "Open Files Tree", key = "o", action = ":NvimTreeToggle" },
			{ icon = " ", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')", key = "r" },
			{ icon = "󰮗 ", desc = "Find Files", action = ":lua Snacks.dashboard.pick('files')", key = "f" },
			{ icon = "󱎸 ", desc = "Find Texts", action = ":lua Snacks.dashboard.pick('live_grep')", key = "t" },
			{ icon = " ", desc = "Quit", key = "q", action = ":qa" },
		},
		header = [[
    /￣￣￣￣￣￣￣￣\
    |  Hello Kanro!  |
    \_______  _______/
            ⋁
          /\__/\
    /`)  ( ・ ∀・)
   __(_(___∅____⊂_)_
  ／    © neko    ／|
  |￣￣￣￣￣￣￣ | |
  |_______________|／

✨ Powered by nekoVim ✨]],
	},
	sections = {
		{ section = "header", gap = 1, padding = 2 },
		{ section = "startup", gap = 1, padding = 2 },
		{ section = "keys", gap = 1, padding = 2, pane = isWide and 2 or 1 },
		-- { section = "projects", icon = " ", title = "Projects\n", padding = 2, pane = paneNum },
		{
			section = "recent_files",
			icon = " ",
			title = "Recent Files\n-------",
			limit = 8,
			padding = 2,
			pane = isWide and 3 or 1,
		},
	},
}

local indentConfig = {
	enabled = true,
	priority = 1,
	char = "│",
	only_scope = false, -- only show indent guides of the scope
	only_current = false, -- only show indent guides in the current window
	animate = {
		easing = "linear",
		duration = {
			step = 20, -- ms per step
			total = 300, -- maximum duration
		},
	},
}

local termConfig = {
	shell = "zsh",
	win = {},
}

local notifierConfig = {
	enabled = true,
	width = { min = 40, max = 0.4 },
}

local config = {
	dashboard = dbConfig,
	indent = indentConfig,
	terminal = termConfig,
	input = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
	notifier = notifierConfig,
	scope = { enabled = true },
}

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 900,
	opts = config,
}
