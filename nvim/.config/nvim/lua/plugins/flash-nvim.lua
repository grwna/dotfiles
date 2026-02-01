return {
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {
        highlight = {
                backdrop = false,
            },
        modes = { -- try these enabled first
          search = { enabled = false },
          char = { 
                    enabled = false,
                    highlight = {
                        backdrop = false,
                    }
                },
        },
      },
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
      },
    },
}
