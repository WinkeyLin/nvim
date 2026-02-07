return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				delete = { text = "󰍵" },
				changedelete = { text = "󱕖" },
			},
		},
	},
	-- support code highlight for chezmoi templates
	{
		"alker0/chezmoi.vim",
		lazy = false,
		-- event = { "BufReadPre */chezmoi/*" },
		init = function()
			vim.g["chezmoi#use_tmp_buffer"] = true
			vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/code/chezmoi/home/"
		end,
	},
	-- {
	--	"xvzc/chezmoi.nvim",
	--	dependencies = { "nvim-lua/plenary.nvim" },
	--	-- load only when editing files in chezmoi repo
	--	event = { "BufReadPre */chezmoi/*" },
	--	config = function()
	--		require("chezmoi").setup({})
	--	end,
	--},
}
