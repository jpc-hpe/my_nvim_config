return {
  "folke/which-key.nvim",
  opts = {
    keys = {
      scroll_down = "<S-Up>", -- binding to scroll down inside the popup
      scroll_up = "<S-Down>", -- binding to scroll up inside the popup
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
