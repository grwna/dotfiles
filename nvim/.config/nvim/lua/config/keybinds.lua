-- Advanced keymappings (collection of plugin e)
local wk = require("which-key")

wk.add({
    -- superkey labeling
    { "<leader>f", group = "+Find" },
    { "<leader>sr", group = "+Search and Replace" },
    { "<leader>b", group = "+Buffers" },
    { "<leader>a", group = "+AI" },

    { "<leader>lz", "<cmd>Lazy<cr>", desc = "Open Lazy Menu" },
    { "<leader>qq", "<cmd>q!<cr>", desc = "Quit Neovim" },
    { "<leader>wq", "<cmd>wq<cr>", desc = "Quit Neovim and Save File" },
    { "<leader>m", "<cmd>messages<cr>", desc = "Open System Messages" },
    { "<leader>ya", "<cmd>%y<cr>", desc = "Yank whole file" },
    { "<leader>yA", "<cmd>%y+<cr>", desc = "Yank whole file into system clipboard" },

    -- buffers
    { "<leader>bb", "<cmd>b#<cr>", desc = "Go to most recent Buffer" },
    { "<leader>bh", "<cmd>bp<cr>", desc = "Go to the next Buffer in the list" },
    { "<leader>bl", "<cmd>bn<cr>", desc = "Go to the previous Buffer in the list" },

    -- command line
    { "<leader>:", "q:", desc = "Open Command Line Window" },

    -- harpoon
    {"<leader>1", hidden = true},
    {"<leader>2", hidden = true},
    {"<leader>3", hidden = true},
    {"<leader>4", hidden = true},

})
