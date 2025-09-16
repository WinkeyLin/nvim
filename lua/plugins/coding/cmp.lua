local cmpConfig = function()
	local cmp = require "cmp"
	local options = {
		-- 补全菜单将始终显示，即使只有一个匹配项
		completion = { completeopt = "menu,menuone" },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "path" },
		},
		mapping = require("configs.keymap").cmp(cmp)
	}
	-- / 查找模式使用 buffer 源
	cmp.setup.cmdline("/", {
		mapping = require("configs.keymap").cmp(cmp),
		sources = {
			{ name = "buffer" },
		},
	})
	-- : 命令行模式中使用 path 和 cmdline 源
	cmp.setup.cmdline(":", {
		mapping = require("configs.keymap").cmp(cmp),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
	return options
end

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
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
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
					-- setup cmp for autopairs
					-- cmp 补全时自动插入括号
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end
			},
			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline"
			},
		},
		config = function()
			require("cmp").setup(cmpConfig())
		end
	},
}
