local luasnipSetup = function()
	require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
	require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
	-- snipmate format
	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
	-- lua format
	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if
					require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		version = "1.*",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				version = "v2.*",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					luasnipSetup()
				end
			},
			{
				-- autopairing of (){}[] etc
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {
						map = "<C-)>"
					},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
				end
			},
		},
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<Esc>"] = { "hide", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				ghost_text = { enabled = false },
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "none",
					["<C-Space>"] = { "show" },
					["<Esc>"] = { "hide", "fallback" },
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<CR>"] = { "select_and_accept", "fallback" },
				},
				completion = { menu = { auto_show = true } },
			},
			-- Avoid extra downloads/builds; keep behavior stable in restricted networks.
			fuzzy = { implementation = "lua" },
		},
	},
	-- surround: add/change/delete surrounding pairs
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
}
