-- https://github.com/nvim-tree/nvim-tree.lua
-- file managing , picker etc

-- disable budit-in file browser plugin netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local config = {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  -- 在目录树中定位当前打开的文件
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 20,
    preserve_window_proportions = true,
    float = {
      enable = vim.api.nvim_win_get_width(0)>70 and false or true

    }
  },
  actions = {
    change_dir = {
      global = true,
    },
    open_file = {
      quit_on_open = true
    },
  },
  trash = {
    cmd = "trash-put",
  },
  -- 显示被修改且未保存的文件
  modified = {
    enable = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = config
  }
}
