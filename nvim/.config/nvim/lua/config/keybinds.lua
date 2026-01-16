-- Advanced keymappings (collection of plugin e)
local wk = require("which-key")

wk.add({
  { "<leader>lz", "<cmd>Lazy<cr>", desc = "Open Lazy Menu" },
  { "<leader>qq", "<cmd>q!<cr>", desc = "Quit Neovim" },
  { "<leader>wq", "<cmd>wq<cr>", desc = "Quit Neovim and Save File" },
  { "<leader>m", "<cmd>messages<cr>", desc = "Open System Messages" },
  { "<leader>bb", "<cmd>b#<cr>", desc = "Switch to Most Recent Buffer" },

})
