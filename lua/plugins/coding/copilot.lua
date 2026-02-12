-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = { "InsertEnter" },
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = { "CopilotChat", "CopilotChatToggle" },
		opts = {
			model = "gpt-5.2",
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
