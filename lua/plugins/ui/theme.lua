local config = {
  flavour = "frappe",
  no_italic = true,
  no_bold = true,
  integrations = {
    mason = true,
    which_key = true,
    snacks = true
  }
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function ()
    require("catppuccin").setup(config)
    vim.cmd.colorscheme "catppuccin"
  end
}
