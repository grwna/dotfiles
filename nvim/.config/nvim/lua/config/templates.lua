-- lua/config/templates.lua
local M = {}

M.dir = vim.fn.stdpath("config") .. "/templates"

local function insert(win, buf, lines)
  if #lines == 0 then return end
  if not vim.bo[buf].modifiable then
    vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  vim.api.nvim_win_call(win, function()
    local indent = vim.api.nvim_get_current_line():match("^%s*")
    for i = 2, #lines do
      if lines[i] ~= "" then lines[i] = indent .. lines[i] end
    end
    -- charwise, before cursor, do not move cursor
    vim.api.nvim_put(lines, "c", false, false)
  end)
end

function M.pick()
  if vim.fn.isdirectory(M.dir) == 0 then
    vim.notify("Templates dir not found: " .. M.dir, vim.log.levels.ERROR)
    return
  end

  -- capture target before the picker steals focus
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  Snacks.picker.files({
    title = "Templates",
    cwd = M.dir,
    confirm = function(picker, item)
      picker:close()
      if not item then return end
      local path = Snacks.picker.util.path(item)
      insert(win, buf, vim.fn.readfile(path))
    end,
  })
end

return M
