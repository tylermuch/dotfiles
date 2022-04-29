local nvim_lsp = require "lspconfig"
local lsp_status = require("lsp-status")
local coq = require "coq"
local cmp = require'cmp'

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = cmp.config.sources({
    { name = "treesitter" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  })
})

local caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

  require'completion'.on_attach(client)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
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

  nvim_lsp[lsp].setup {
    coq.lsp_ensure_capablities
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
