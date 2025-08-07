return {
  "folke/tokyonight.nvim",
  lazy = false,
  opts = {
    on_highlights = function(hl, c)
      hl.WinSeparator = { bold = true, bg = "#303030", fg = "#605050" } -- line between splits was barely visible
      hl.BlinkCmpGhostText = { fg = "#80FFFF" } -- ghost text from copilot+blink was too dark
    end,
  },
}
