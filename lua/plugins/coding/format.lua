-- formatting

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier", stop_after_first = true },
        default_format_opts = {
          lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  }
}