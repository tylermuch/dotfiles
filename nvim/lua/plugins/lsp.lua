return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    autoformat  = false,
    setup = {
      clangd = function (_, opts)
      opts.cmd = {"clangd", "--header-insertion=never"}
      end,
    }
  },
}
