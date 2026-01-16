------------------------------
--- DISABLE BUIILT IN PLUGINS
------------------------------
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_conv",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
