return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    view_options = { show_hidden = true },
    confirmation = { border = "single" },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "-", "<CMD>Oil<CR>")
  end,
}
