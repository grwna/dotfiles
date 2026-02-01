return {
  "saghen/blink.cmp",
  version = "v0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "Kaiser-Yang/blink-cmp-avante",
  },

  opts = {
    keymap = {
      preset = "none",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "avante" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {},
        },
      },
    },

    signature = { enabled = true },
  },
}
