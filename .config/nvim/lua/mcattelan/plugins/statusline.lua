return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_b = { { "branch", icons_enabled = false } },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = { { "diagnostics", symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" } } },
      lualine_z = { { "location" }, { "filetype", icons_enabled = false } },
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
