local function copilot_status()
    if not package.loaded["copilot"] then
      return ""
    end



    local is_enabled = vim.b.copilot_suggestion_auto_trigger
    if is_enabled then
        return " "
    else
        return " "
    end
end

local has_lualine, lualine = pcall(require, "lualine")
if has_lualine then
    require('lualine').setup {
      sections = {
        lualine_x = {
          {
            copilot_status,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    }
end
