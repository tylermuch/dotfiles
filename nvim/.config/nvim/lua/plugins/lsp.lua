-- Set the clangd path according to xcrun if we're running on macOS
-- This is to try to silence warnings/errors stemming from build with an instance of clang from
--   a mismatched toolchain.
local clangd_path = "clangd"
local sysname = vim.loop.os_uname().sysname

if sysname == "Darwin" then
  local handle = io.popen('xcrun -f clangd')
  if handle == nil then return end

  local result = handle:read("*a")
  handle:close()

  clangd_path = result:gsub("\n$", "")
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    autoformat  = false,
    setup = {
      clangd = function (_, opts)
      opts.cmd = { clangd_path, "--header-insertion=never"}
      end,
    }
  },
}
