return {
  "nvim-lualine/lualine.nvim",
  --[[ JPC: this is when you want to insert and not override
  opts = function(_, opts)
    table.insert(opts.sections.lualine_z, {
      "encoding",
    })
  end,
--]]
  opts = {
    winbar = {
      lualine_a = { "lsp_status" },
      lualine_b = { "searchcount" },
      lualine_y = {
        function()
          if not vim.b.blink_or_copilot or vim.b.blink_or_copilot > 2 then
            return "??!!"
          elseif vim.b.blink_or_copilot == 0 then
            return "None"
          elseif vim.b.blink_or_copilot == 1 then
            return "Blink"
          elseif vim.b.blink_or_copilot == 2 then
            return "Copilot"
          end
        end,
      },
      lualine_z = { "filetype", "encoding", "fileformat", "filesize" },
    },
  },
}
