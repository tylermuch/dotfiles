return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.config/nvim/.markdownlint-cli2.yaml"), "-" },
        },
      },
    },
  },
}

