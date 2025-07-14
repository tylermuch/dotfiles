return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      symbols = {
        focus = true,
        win = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  },
}
