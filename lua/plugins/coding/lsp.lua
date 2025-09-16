-- LSP 代码错误提示
vim.diagnostic.config({
	--  在代码后显示文字错误提示
	virtual_text = true,
	-- 在代号处显示图标错误提示
	signs = true,
	-- 在输入模式下也显示提示
	update_in_insert = true,
})
-- 自定义错误提示图标
local signs = { Error = "󰅙", Warn = "", Hint = "󰌵", Info = "󰋼" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local masonConfig = {
	-- Where Mason should put its bin location in your PATH
	PATH = "prepend",
	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
	max_concurrent_installers = 10,
}

return {
	-- LSP Server manger
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = masonConfig,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		cmd = { "LspInfo" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "lua_ls", "jsonls" },
				automatic_enable = true,
			})

			-- 使用新的 vim.lsp.config API 配置 LSP 服务器
			local on_attach = function(_, bufnr)
				require("configs.keymap").lsp(bufnr)
			end
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- 为 lua_ls 添加特殊配置，使用新的 vim.lsp.config API
			vim.lsp.config('lua_ls', {
				cmd = { 'lua-language-server' },
				filetypes = { 'lua' },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						diagnostics = {
							globals = { 'vim', 'require' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- 为其他服务器设置通用配置
			vim.lsp.config('ts_ls', {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config('jsonls', {
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
