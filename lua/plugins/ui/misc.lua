return {
  -- basic lib dependency
  { "nvim-lua/plenary.nvim", lazy = false },
  -- add beautiful and configurable icons
  { "nvim-tree/nvim-web-devicons", lazy = false },
  -- UI dependency
  { "nvzone/volt" },
  -- add right-click menu
  { "nvzone/menu" },
  -- add color picker in right-click menu
  {
    "nvzone/minty",
    cmd = { "Huefy", "Shades" }
  }
}
