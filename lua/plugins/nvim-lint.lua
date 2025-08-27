local CONFIG = vim.fn.stdpath("config")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", CONFIG .. "/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
