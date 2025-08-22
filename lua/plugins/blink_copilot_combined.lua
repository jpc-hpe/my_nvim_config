return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Keymap override. These are my current preferences
      opts.keymap = opts.keymap or {}
      opts.keymap.preset = "none"
      opts.keymap["<Tab>"] = { "accept", "fallback" }
      opts.keymap["<Up>"] = { "select_prev", "fallback" }
      opts.keymap["<Down>"] = { "select_next", "fallback" }
      opts.keymap["<F2>"] = { "show", "show_documentation", "hide_documentation" }
      opts.keymap["<C-e>"] = { "cancel", "fallback" }
      opts.keymap["<C-b>"] = { "scroll_documentation_up", "fallback" }
      opts.keymap["<C-f>"] = { "scroll_documentation_down", "fallback" }
      opts.keymap["<C-k>"] = { "show_signature", "hide_signature", "fallback" }
      opts.keymap["<F4>"] = { "snippet_forward", "fallback" }
      opts.keymap["<F5>"] = { "snippet_backward", "fallback" }

      -- Filter copilot from default sources, so we use copilot.lua native.
      if opts.sources and opts.sources.default then
        opts.sources.default = vim.tbl_filter(function(source)
          return source ~= "copilot"
        end, opts.sources.default)
      end
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        -- My current preferences.
        --     Tab completes as in blink
        --     C-e (for "end") discards as in blink
        --     Alt+right completes just one word, Alt+down completes just one line
        --     C-n and C-p switch to next/prev suggestions
        keymap = {
          accept = "<TAB>",
          accept_word = "<M-Right>",
          accept_line = "<M-Down>",
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-e>",
        },
      },
      panel = {
        enabled = false,
      },
      should_attach = function(_, _)
        -- This uses the the buffer variable controlled by the keymap
        return (vim.b.blink_or_copilot == 2)
      end,
    },
  },
}
