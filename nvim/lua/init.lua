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
        sections = { 'error', 'warn', 'info' },
        diagnostics_color = {
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
        symbols = { error = 'E', warn = 'W', info = 'I'},
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    },
    lualine_a = {
      "require'lsp-status'.status()"
    }
  }
}

local on_attach = function(client, bufnr)
  lsp_status.register_progress()
  lsp_status.config(
    {
      status_symbol = "LSP ",
      indicator_errors = "E",
      indicator_warning = "W",
      indicator_info = "I",
      indicator_hint = "H",
      indicator_ok = "ok",
      diagnostics = false,
    }
  )

  vim.diagnostic.config({ virtual_text = false })

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
  ensure_installed = { "c", "cmake", "cpp", "comment", "diff", "git_config", "linkerscript", "lua" ,"markdown", "python", "rust", "tmux", "vim", "yaml" },
  ignore_install = { "all" },

  sync_install = false,

  highlight = {
    enable = true,
  },
}

require("tiny-inline-diagnostic").setup({
})

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
require("toggleterm").setup()

local ufo_fold_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
require('ufo').setup({
    fold_virt_text_handler = ufo_fold_handler
})

-- nvim-ufo plugin configuration
-- https://github.com/kevinhwang91/nvim-ufo
vim.o.foldcolumn = '0' -- How many columns of fold information to show in the left sidebar (left of the line numbers)
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
