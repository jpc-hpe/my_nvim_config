--[[
--JPC: This could be also achieved by simply adding
--vim.diagnostic.config({ virtual_text = false })
--in lua/config/options.lua
--]]
return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
