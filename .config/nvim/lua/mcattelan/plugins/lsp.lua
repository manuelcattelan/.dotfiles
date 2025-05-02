return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = { ui = { border = "single", backdrop = 100 } },
    config = function(_, opts)
      local mason = require("mason")
      local mason_registry = require("mason-registry")
      mason.setup(opts)
      if mason_registry.refresh then
        mason_registry.refresh()
      end
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp", "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        float = { border = "single" },
        jump = { float = true },
      })
      local servers = { lua_ls = {} }
      local handlers = {
        function(server_name)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      }
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers or {}),
        automatic_installation = false,
        handlers = handlers,
      })
    end,
  },
}
