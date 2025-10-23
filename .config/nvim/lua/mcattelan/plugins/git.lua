return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { buffer = bufnr })
      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr })
      vim.keymap.set("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { buffer = bufnr })
      vim.keymap.set("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { buffer = bufnr })
    end,
  },
}
