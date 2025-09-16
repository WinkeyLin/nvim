local function config(bufferline)
  return {
    options = {
      style_preset = {
        bufferline.style_preset.no_italic,
        bufferline.style_preset.no_bold
      },
      offsets = {
        { filetype = "NvimTree" }
      },
      groups = {
        items = { require('bufferline.groups').builtin.pinned:with({ icon = "  " }) }
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      tab_size = 13,
      buffer_close_icon = '󰅙',
      modified_icon = ' ',
      middle_mouse_command = "bdelete! %d",
      right_mouse_command = "BufferLineTogglePin"
    },
    highlights = {}
  }
end

return {
  "akinsho/bufferline.nvim",
  lazy = false,
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")
    vim.opt.termguicolors = true
    require("bufferline").setup(config(bufferline))
  end
}
