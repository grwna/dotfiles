return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    
    opts = {},
    keys = {
        { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session", },
        { "<leader>sS", function() require("persistence").select() end, desc = "Open Session List", },
        { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Global Session", },
        { "<leader>sd", function() require("persistence").stop() end, desc = "Disable Persistence", },
    }
}
