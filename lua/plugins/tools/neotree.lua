-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- disable built-in file browser plugin netrw (keeps behavior consistent with previous nvim-tree setup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- Prevent neo-tree panels from being closed when it is the last window
			close_if_last_window = false,
			-- Prefer opening files in the last active non-neo-tree window when possible
			open_files_in_last_window = true,
			-- Blacklist of window types that should not be replaced by opened files
			open_files_do_not_replace_types = { "neo-tree", "neo-tree-popup", "terminal", "trouble", "Trouble", "qf" },
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = {
					with_markers = true,
					indent_size = 2,
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "󰈚",
				},
				modified = { symbol = " " },
				git_status = {
					symbols = {
						unmerged = "",
					},
				},
			},
			window = {
				position = "left",
				width = 20,
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = true },
				group_empty_dirs = true,
				use_libuv_file_watcher = true,
			},
		},
	},
}
