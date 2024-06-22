-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

if vim.g.neovide then
  -- disable cursor animation
  vim.g.neovide_cursor_animation_length = 0

  vim.o.guifont = "MesloLGS Nerd Font Mono:h16"

  vim.g.neovide_padding_top = 5
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 5
  vim.g.neovide_padding_left = 5

  vim.g.neovide_transparency = 1
  vim.g.transparency = 0
  vim.g.neovide_window_blurred = false

  vim.g.neovide_scroll_animation_length = 0.1

  vim.opt.linespace = 0
end
