return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	cmd = "WhichKey",
	opts = {
		preset = "modern",
		triggers = { "<leader>", mode = { "n", "v" } },
		win = {
			padding = { 1, 1 },
		},
		layout = {
			width = { min = 10, max = 25 },
			wo = { winblend = 20 },
		},
	},
}
