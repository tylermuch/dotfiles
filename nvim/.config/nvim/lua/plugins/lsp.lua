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
    servers = {
      -- Keep lua_ls from indexing/diagnosing every .lua file in huge workspaces.
      -- TODO: revisit limits if cross-file hover/completion feels too stingy.
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              maxPreload      = 200,  -- default 5000
              preloadFileSize = 100,  -- KB, default 500
              ignoreDir       = { "build", "out", "node_modules", ".git", "third_party" },
            },
            diagnostics = {
              -- Only diagnose open files, never the whole workspace
              workspaceDelay = -1,
              workspaceEvent = "None",
            },
          },
        },
      },
    },
    setup = {
      clangd = function (_, opts)
      opts.cmd = { clangd_path, "--header-insertion=never"}
      end,
    }
  },
}
