vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local goto_diagnostic = function(diagnostic_direction, diagnostic_severity)
      local jump_severity = diagnostic_severity and vim.diagnostic.severity[diagnostic_severity] or nil
      local jump_direction = diagnostic_direction == "next" and 1 or -1
      local jump_options = { count = jump_direction, severity = jump_severity }
      return function()
        return vim.diagnostic.jump(jump_options)
      end
    end
    vim.keymap.set("n", "[d", goto_diagnostic("prev"))
    vim.keymap.set("n", "]d", goto_diagnostic("next"))
    vim.keymap.set("n", "[w", goto_diagnostic("prev", "WARN"))
    vim.keymap.set("n", "]w", goto_diagnostic("next", "WARN"))
    vim.keymap.set("n", "[e", goto_diagnostic("prev", "ERROR"))
    vim.keymap.set("n", "]e", goto_diagnostic("next", "ERROR"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, { buffer = args.buf })
    vim.keymap.set({ "n", "i" }, "<C-k>", function()
      vim.lsp.buf.signature_help({ border = "single" })
    end, { buffer = args.buf })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  end,
})
