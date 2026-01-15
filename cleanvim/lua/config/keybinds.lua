-- Advanced keymappings (collection of plugin e)
local wk = require("which-key")

wk.add({
  { "<leader>Lz", "<cmd>Lazy<cr>", desc = "Open Lazy Menu" },
  { "<leader>m", "<cmd>messages<cr>", desc = "Open System Messages" },
  { "<leader>bb", "<cmd>b#<cr>", desc = "Switch to Most Recent Buffer" },

})
