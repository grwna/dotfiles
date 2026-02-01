local picker_dropdown = {layout = { preset = "dropdown"}}
local picker_ivy = {layout = { preset = "ivy_split"}}
local picker_right = {layout = { preset = "right"}}
local picker_select = {layout = { preset = "select"}}

local grep_settings = {
  layout = { preset = "ivy_split" },
  args = { "--fixed-strings" }, 
}

return {
  enabled = true,

  hidden = true, -- index hidden files
  ignored = false, -- don't index ignored files

  matcher = {
    frecency = true,
  },

  win = {
    -- TODO: understand how input/result/preview focus works, currently only dealing with input (good enough honestly)
    input = {
      keys = {
        ["<C-q>"] = { "qflist", mode = { "i", "n" } },
        ["<C-e>"] = { "jump", mode = { "i", "n" } },
        ["<C-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<C-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },

      },
    },
  },

  layout = {
    preset = "ivy_split",
    preview = "main", -- preview as the main
  },
  
    args = {"--fixed-strings"},

    formatters = {
        file = {
            filename_first = "left",
            truncate = 80,
        },
    },
  -- Per-Source Configuration
  sources = {
    -- dropdowns
    files = picker_dropdown,
    colorschemes = picker_dropdown,
    git_branches = picker_dropdown,
    git_status = picker_dropdown,
    git_files = picker_dropdown,

    grep = grep_settings,
    grep_buffers = grep_settings,
    git_grep = grep_settings,

    diagnostics = picker_ivy,
    diagnostics_buffer = picker_ivy,
    git_diff = picker_ivy,
    git_log = picker_ivy,
    git_log_file = picker_ivy,
    git_log_line = picker_ivy,
    git_stash = picker_ivy,
    -- NOTE: i don't do github operations from within neovim
    notifications = picker_ivy,

    man = picker_right,
    help = picker_right,
    todo_comments = picker_right,
    buffers = {layout = {preset = "left"}},

    autocmds = picker_select,
    command_history = picker_select,
    commands = picker_select,
    icons = picker_select,

    keymaps = picker_ivy,

    pickers = {
        layout = {
                preset = "dropdown",
                preview = false,
            }
        },

    -- custom todo-buffer picker
    -- todo_comments_buffer = {
    --     layout = {preset = "ivy"},
    --     fn = "grep_buffers",
    --     desc = "Seach TODO comments in buffer",
    --     opts = {
    --         search = function ()
    --             local ok, todo = pcall(require, "todo-comments.config")
    --             local keywords = ok and table.concat(vim.tbl_keys(todo.keywords), "|")
    --             return [[\b(]] .. keywords .. [[)\b]]
    --         end,
    --         regex = true,
    --     }
    -- },
  }
}
