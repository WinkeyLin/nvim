-- https://github.com/nvim-treesitter/nvim-treesitter

local parser_languages = {
  "javascript", "typescript", "python",
  "lua", "vim",
  "markdown", "bash",
  "json", "yaml", "toml"
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  priority = 1000,
  cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate", "TSUninstall", "TSLog" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup()
    treesitter.install(parser_languages)

    local group = vim.api.nvim_create_augroup("nvim_treesitter_features", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "*",
      callback = function(args)
        local is_enabled = pcall(vim.treesitter.start, args.buf)
        -- only enable treesitter for supported filetypes
        if not is_enabled then
          return
        end
        -- enable code folding, unfold by default
        vim.wo[0].foldmethod = "expr"
        vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0].foldenable = false
        -- enable code indent
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
