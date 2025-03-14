vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { bang = true })

vim.api.nvim_create_user_command("Format", function(args)
  local range_to_format = nil

  if args.count ~= -1 then
    local range_end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

    range_to_format = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, range_end_line:len() },
    }
  end

  require("conform").format({
    async = true,
    lsp_format = "fallback",
    range = range_to_format,
  })
end, { range = true })
