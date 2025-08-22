-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- JPC: Force filetype passtxt to avoid copilot when filename contains "pass" (case insensitive)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function(args)
    local fname = vim.fn.fnamemodify(args.file, ":t"):lower()
    if fname:find("pass") then
      vim.bo.filetype = "passtxt"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function(args)
    vim.b.blink_or_copilot = 0
    vim.b.completion = false
    vim.api.nvim_command("Copilot detach")
  end,
})
