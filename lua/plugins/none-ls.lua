local CONFIG = vim.fn.stdpath("config")
return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")

      opts.sources = vim.tbl_map(function(source)
        if source.name == "markdownlint-cli2" then
          return source.with({
            -- to_stdin = true,
            args = { "--config", CONFIG .. "/.markdownlint-cli2.yaml", "--", "$FILENAME" },
          })
        end
        return source
      end, opts.sources or {})
    end,
  },
}
