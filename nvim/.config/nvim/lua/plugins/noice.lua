return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets = {
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = "95%",
              col = "10%"
            }
          }
        }
      }
    }
  end
}
