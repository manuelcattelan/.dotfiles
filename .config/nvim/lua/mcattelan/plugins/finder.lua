return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  opts = {
    defaults = {
      layout_config = { preview_width = 80 },
      preview = { hide_on_startup = true },
      borderchars = {
        prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      mappings = { i = { ["<C-h>"] = require("telescope.actions.layout").toggle_preview } },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
    vim.keymap.set("n", "<space>fd", function()
      require("telescope.builtin").find_files({ hidden = true })
    end)
    vim.keymap.set("n", "<space>fg", function()
      require("telescope.builtin").git_files({ show_untracked = true })
    end)
    vim.keymap.set("n", "<space>gc", require("telescope.builtin").grep_string)
    vim.keymap.set("n", "<space>gs", require("telescope.builtin").live_grep)
  end,
}
