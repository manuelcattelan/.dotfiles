local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      { { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("mcattelan.core.keymaps")
require("mcattelan.core.options")
require("mcattelan.core.autocommands")
require("mcattelan.core.usercommands")

require("lazy").setup({
  spec = { { import = "mcattelan.plugins" } },
  install = { colorscheme = { "tokyonight" } },
  change_detection = { enabled = false },
  ui = { border = "single", backdrop = 100 },
})
