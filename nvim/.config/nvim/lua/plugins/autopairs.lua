-- taken directly from "https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/autopairs.lua"
return {
  -- "windwp/nvim-autopairs",
  -- event = { "InsertEnter" },
  --   enabled = false,
  -- dependencies = {
  --   "hrsh7th/nvim-cmp",
  -- },
  -- config = function()
  --   -- import nvim-autopairs
  --   local autopairs = require("nvim-autopairs")
  --
  --   -- configure autopairs
  --   autopairs.setup({
  --     check_ts = true, -- enable treesitter
  --     ts_config = {
  --       lua = { "string" }, -- don't add pairs in lua string treesitter nodes
  --       javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
  --       java = false, -- don't check treesitter on java
  --     },
  --   })
  --
  --   -- import nvim-autopairs completion functionality
  --   local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --
  --   -- import nvim-cmp plugin (completions plugin)
  --   local cmp = require("cmp")
  --
  --   -- make autopairs and completion work together
  --   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  -- end,

    -- THE ABOVE CODE IS FOR NVIM-CMP, BELOW IS FOR WORKING WITH BLINK-CMP

    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")

      -- configure autopairs
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

    end
}
