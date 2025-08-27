-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- JPC This leader keys are nice for a spanish keyboard layout
vim.g.mapleader = "º"
vim.g.maplocalleader = "ª"
-- JPC I have a dedicated virtualenv for the python provider
-- It has of course pynvim installed
vim.g.python_host_prog = "~/myenvs/py/nvim/bin/python"
vim.g.python3_host_prog = "~/myenvs/py/nvim/bin/python"
-- JPC disable perl and ruby providers so ':checkhealth' does not complain about them
vim.g.loaded_perl_provider = 0 -- in .vim this would be "let g:loaded_perl_provider = 0"
vim.g.loaded_ruby_provider = 0

-- JPC this disbales copilot for the special filetype that I am using in autocommands
vim.g.copilot_filetypes = {
  passtxt = false,
}

-- vim.o.foldmethod = "syntax" -- JPC I tried this but the default uses treesitter and works better
-- JPC the following are my personal preferences on how to show things
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = false -- Show absolute line numbers
vim.o.visualbell = true
vim.o.showmatch = true -- Show matching brackets
vim.o.wildoptions = "fuzzy,pum,tagfile" -- Enable fuzzy matching, popup menu, and tags in command-line completion
--vim.o.tabstop = 4       -- Number of spaces that a <Tab> in the file counts for
--vim.o.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
vim.o.showbreak = "\\ " -- String to put at the start of wrapped lines
vim.o.breakindent = true -- Wrap indent to match line start
vim.o.sidescrolloff = 3 -- Minimum number of columns to the left/right of the cursor
vim.o.title = true -- Set the terminal title to the file name

vim.g.autoformat = false -- I prefer to manually format with <Leader>cf or :LazyFormat
-- vim.g.snacks_animate = false ??
vim.g.deprecation_warnings= true
