local nvim_lsp = require "lspconfig"
local lsp_status = require("lsp-status")

require('lualine').setup {
  sections = {
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    }
  }
}

local on_attach = function(client, bufnr)
  lsp_status.register_progress()
  lsp_status.config(
    {
      status_symbols = "LSP ",
      indicator_errors = "E",
      indicator_warning = "W",
      indicator_info = "I",
      indicator_hint = "H",
      indicator_ok = "ok"
    }
  )

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

  require 'illuminate'.on_attach(client)
end

local servers = {
  "clangd",
  "pyright",
  "rust_analyzer"
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },

  sync_install = false,

  highlight = {
    enable = true,
  },
}

-- Ugh, telescope kinda sucks

require('telescope').setup {
  defaults = {
    previewer = true,
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.9,
      height = 0.8,
      -- prompt_position = 'top',
      mirror = true,
    },
    -- path_display = {"smart"},
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
}

require('highlight_current_n').setup({
  highlight_group = "IncSearch"
})

require('neoclip').setup()

require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}
