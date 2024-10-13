-- ~/.config/nvim/ftplugin/cs.lua

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

-- Optional: Set textwidth for C# files
vim.bo.textwidth = 120

-- Optional: Enable autoindent and smartindent
vim.bo.autoindent = true
vim.bo.smartindent = true

-- Prevent these settings from being overwritten
vim.bo.modeline = false
