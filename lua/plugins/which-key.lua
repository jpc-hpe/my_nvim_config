return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    keys = {
      scroll_up = "<S-Up>", -- binding to scroll down inside the popup
      scroll_down = "<S-Down>", -- binding to scroll up inside the popup
    },
  },
  keys = {
    {
      "<M-C-w>",
      function()
        vim.cmd("stopinsert")
        require("which-key").show()
      end,
      mode = "i",
      silent = true,
      desc = "Show which-key popup",
    },
  },
}
