-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- JPC: keybindings for my chitshit plugin. I didn't see anyone using "<leader><leader>"
-- so i decided to use "<leader><leader>c" for chitshit commands
vim.keymap.set(
  "n",
  "<Leader><Leader>kc",
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
vim.keymap.set("n", "<Leader><Leader>kd", function()
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
    -- JPC: disable messages as I will have lualine telling me the status
    -- print("Disabling both blink and copilot")
    vim.b.completion = false
    vim.api.nvim_command("Copilot detach")
    vim.b.blink_or_copilot = 0
  elseif vim.b.blink_or_copilot == 0 then
    -- print("Using blink")
    vim.b.completion = true
    vim.api.nvim_command("Copilot detach")
    vim.b.blink_or_copilot = 1
  elseif vim.b.blink_or_copilot == 1 then
    -- print("Using copilot")
    vim.b.completion = false
    vim.api.nvim_command("Copilot! attach")
    vim.b.blink_or_copilot = 2
  end
end, { desc = "Cycle Blink.cmp and Copilot states" })

local function command_in_file_cwd(cmd)
  local previous_cwd = vim.fn.getcwd()
  local target_cwd = vim.fn.expand("%:p:h")
  -- print("JPC prev is " .. previous_cwd .. " target is " .. target_cwd)
  if target_cwd ~= "" and target_cwd ~= previous_cwd then
    vim.cmd("cd " .. vim.fn.fnameescape(target_cwd))
    vim.cmd(cmd)
    vim.cmd("cd " .. vim.fn.fnameescape(previous_cwd))
  else
    vim.cmd(cmd)
  end
end

vim.keymap.set("n", "<leader><leader>tq", function()
  command_in_file_cwd("TodoQuickFix")
end, { desc = "Quickfix TODOs in current file" })
vim.keymap.set("n", "<leader><leader>tl", function()
  command_in_file_cwd("TodoLocList")
end, { desc = "LocList TODOs in current file" })
vim.keymap.set("n", "<leader><leader>tt", function()
  command_in_file_cwd("Trouble todo")
end, { desc = "Trouble TODOs in current file" })
vim.keymap.set("n", "<leader><leader>tf", function()
  command_in_file_cwd("TodoFzfLua")
end, { desc = "Fzf TODOs in current file" })

vim.keymap.set("n", "<leader><leader>lh", ":LspToggle harper_ls<CR>", { desc = "Toggle harper_ls" })
vim.keymap.set("n", "<leader><leader>lv", ":LspToggle vale_ls<CR>", { desc = "Toggle vale_ls" })
vim.keymap.set(
  "n",
  "<leader><leader>ls",
  ":Trouble symbols toggle filter.buf=0 focus=false<CR>",
  { desc = "Trouble symbols" }
)
vim.keymap.set(
  "n",
  "<leader><leader>ld",
  ":Trouble diagnostics toggle filter.buf=0 preview.scratch=false<CR>",
  { desc = "Trouble diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader><leader>ll",
  ":Trouble lsp toggle filter.buf=0<CR>",
  { desc = "Trouble lsp" }
)
