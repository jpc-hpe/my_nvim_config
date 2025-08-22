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

-- JPC: debug keys sent in you environment
vim.keymap.set("n", "<Leader><Leader>cx", function()
  local mod_map = {
    [2] = "shift",
    [4] = "control",
    [8] = "alt",
    [16] = "meta",
    [32] = "mouse double click",
    [64] = "mouse triple click",
    [96] = "mouse quadruple click",
    [128] = "command/super",
  }
  local bitops = require("bit")
  vim.schedule(function()
    while true do
      local key = vim.fn.getcharstr()
      local mods = vim.fn.getcharmod()
      local mod_list = {}
      for bitval, name in pairs(mod_map) do
        if bitops.band(mods, bitval) ~= 0 then
          table.insert(mod_list, name)
        end
      end
      local str = vim.fn.keytrans(key)
      print(str .. (next(mod_list) and (" [" .. table.concat(mod_list, ", ") .. "]") or ""))
      if str == "x" then
        break
      end
    end
  end)
end, {
  noremap = true,
  desc = "Debug keyboard. x to exit",
})

vim.keymap.set({ "i", "n" }, "<M-z>", function()
  if not vim.b.blink_or_copilot or vim.b.blink_or_copilot >= 2 then
    print("Disabling both blink and copilot")
    vim.b.completion = false
    vim.api.nvim_command("Copilot detach")
    vim.b.blink_or_copilot = 0
  elseif vim.b.blink_or_copilot == 0 then
    print("Using blink")
    vim.b.completion = true
    vim.api.nvim_command("Copilot detach")
    vim.b.blink_or_copilot = 1
  elseif vim.b.blink_or_copilot == 1 then
    print("Using copilot")
    vim.b.completion = false
    vim.api.nvim_command("Copilot! attach")
    vim.b.blink_or_copilot = 2
  end
end, { desc = "Cycle Blink.cmp and Copilot states" })
