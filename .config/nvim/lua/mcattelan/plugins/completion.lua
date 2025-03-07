return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = { "L3MON4D3/LuaSnip" },
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-h>"] = { "hide", "fallback" },
      ["<C-s>"] = { "show", "fallback" },
    },
    snippets = { preset = "luasnip" },
    completion = {
      menu = { border = "single" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = "single" },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
