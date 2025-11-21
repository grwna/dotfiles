-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 1. Disable standard clipboard option initially to prevent early probing
vim.opt.clipboard = ""

-- 2. Hardcode the clipboard provider.
-- This completely bypasses the slow provider#clipboard#Executable() check.
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

-- 3. NOW enable syncing, after the provider is hardcoded.
vim.opt.clipboard = "unnamedplus"
