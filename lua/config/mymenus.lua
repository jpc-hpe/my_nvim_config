-- vim.api.nvim_echo({ { "This was executed" } }, true, {})
-- start by removing the unwanted entries
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-2-]])
vim.cmd([[amenu .1 PopUp.Code\ Action <Leader>ca]])
-- JPC: And I stop here. Apparently, menus in non-gui mode do not allow submenus
-- vim.cmd([[amenu PopUp.JPC.Toggleharper_ls <Cmd>LspToggle harper_ls<CR>]])
-- vim.cmd([[amenu pp.JPC.kk :help]])
-- even the experiment below to overcome this is really ugly
-- vim.cmd([[amenu .10 PopUp.JPC <Cmd>popup! JPC<CR>]])
-- vim.cmd([[amenu JPC.LSP <Cmd>popup! JPC_LSP<CR>]])
-- vim.cmd([[amenu JPC_LSP.Toggle\ harper_ls <Cmd>LspToggle harper_ls<CR>]])
-- vim.cmd([[amenu JPC.a.b.c <Cmd>help<CR>]])


