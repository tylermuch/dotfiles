return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        vertical = "up:75%",
        layout = "vertical",
      },
    },
    files = {
      actions = {
        ["default"] = require("fzf-lua.actions").file_edit
      },
    },
  },
}
