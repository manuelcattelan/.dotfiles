vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  end,
})
