-- https://github.com/nvim-treesitter/nvim-treesitter

local config = {
  auto_install = true,
  ensure_installed = { "lua", "json", "javascript", "typescript", "python", "tsx", "vim" },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  -- 代码缩进模块，= 键对选中代码进行缩进
  indent = { enable = true },
  -- 增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      -- Enter 扩大选择范围
      init_selection = "<CR>",
      node_incremental = "<CR>",
      -- Backspace 缩小选择范围
      node_decremental = "<BS>",
      -- Tab 选择下一个代码块
      scope_incremental = "<TAB>",
    },
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = config,
  config = function ()
    require("nvim-treesitter.configs").setup(config)
  end,
}