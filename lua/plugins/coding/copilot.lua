-- https://github.com/github/copilot.vim
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
	{
		"github/copilot.vim",
		event = { "InsertEnter" },
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = { "CopilotChat", "CopilotChatToggle" },
		opts = {
			model = "gpt-4.1",
			show_help = false,
			window = {
				layout = vim.api.nvim_win_get_width(0) > 70 and "vertical" or "horizontal",
				width = 0.3,
				height = 0.3,
			},
			prompts = {
				Explain = {
					prompt = " > /COPILOT_EXPLAIN\n\n请用中文详细地解释这段代码的语法和实现原理",
				},
			},
			mappings = {
				complete = {
					insert = "<C-Space>",
				},
				submit_prompt = {
					insert = "<C-CR>",
				},
			},
		},
	},
}
