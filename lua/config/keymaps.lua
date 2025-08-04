-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- JPC: keybindings for my chitshit plugin. I didn't see anyone using "<leader><leader>"
-- so i decided to use "<leader><leader>c" for chitshit commands
vim.keymap.set(
  "n",
  "<Leader><Leader>ck",
  ":ChitshitKeymaps<CR>",
  { noremap = true, silent = true, desc = "Chitshit: Show keymaps cheatsheet" }
)

-- JPC: Use up/down in command mode completion, instead of the default left/right
-- which is unintuitive for me
vim.o.wildcharm = vim.api.nvim_replace_termcodes("<C-Z>", true, true, true):byte()
vim.keymap.set("c", "<Up>", function()
  return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>"
end, { expr = true })
vim.keymap.set("c", "<Down>", function()
  return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>"
end, { expr = true })
vim.keymap.set("c", "<Left>", function()
  return vim.fn.wildmenumode() == 1 and "<Up>" or "<Left>"
end, { expr = true })
vim.keymap.set("c", "<Right>", function()
  return vim.fn.wildmenumode() == 1 and " <BS><C-Z>" or "<Right>"
end, { expr = true })
