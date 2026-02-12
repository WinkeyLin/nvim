-- LSP diagnostics (signs & display options)
local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "󰅙",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.HINT] = "󰌵",
  [vim.diagnostic.severity.INFO] = "󰋼",
}

vim.diagnostic.config({
  -- Show diagnostic text inline (virtual text)
  virtual_text = true,
  -- Show diagnostic icons in the sign column
  signs = { text = diagnostic_signs },
  -- Update diagnostics in insert mode
  update_in_insert = true,
})

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
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = masonConfig,
  },
  { "neovim/nvim-lspconfig", dependencies = { "saghen/blink.cmp" } },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "ts_ls", "lua_ls", "jsonls" },
      -- mason-lspconfig v2: only auto-enable the servers you want.
      -- This also prevents accidentally enabling non-LSP tools.
      automatic_enable = { "ts_ls", "lua_ls", "jsonls" },
    },
    config = function(_, opts)
      local on_attach = function(_, bufnr)
        require("configs.keymap").lsp(bufnr)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_blink, blink_cmp = pcall(require, "blink.cmp")
      if ok_blink then
        capabilities = blink_cmp.get_lsp_capabilities(capabilities)
      end

      -- Nvim 0.11+: define client configs via `vim.lsp.config()`,
      -- then let mason-lspconfig auto-enable selected servers via `vim.lsp.enable()`.
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              -- Globally treat `vim` as a defined global in all Lua projects.
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              -- Keep this lightweight; pulling in full runtimepath can be very slow.
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      })

      require("mason-lspconfig").setup(opts)
    end,
  },
  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("trouble").setup(opts)
      require("configs.keymap").trouble()
    end,
  },
}
