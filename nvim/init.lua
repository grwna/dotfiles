-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 1. Disable standard clipboard option initially to prevent early probing
vim.opt.clipboard = ""

-- 2. Hardcode the clipboard provider.
-- This completely bypasses the slow provider#clipboard#Executable() check.
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- vim.opt.clipboard = "unnamedplus"
