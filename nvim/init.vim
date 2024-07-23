filetype off

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'nanotech/jellybeans.vim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
Plug 'nvim-lualine/lualine.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rrethy/vim-illuminate'
Plug 'rktjmp/highlight-current-n.nvim'
Plug 'danilamihailov/beacon.nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'f-person/git-blame.nvim'

call plug#end()

lua require('init')

filetype plugin indent on

" Line numbers
set number

" Disable error bells
set noerrorbells

" Spaces > Tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Highlight line that cursor is on
set cursorline

" Preserve padding of at least 5 lines between cursor and top or bottom of the window
set scrolloff=5

" Haven't been bitten by not having an undo file yet...and they're really annoying.
set noundofile
set noswapfile

" Use vertical cursor in insert mode
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

set updatetime=300
set completeopt=menuone
set completeopt+=noinsert
set completeopt-=preview
set shortmess+=c

" fzf in nvim!
" https://github.com/junegunn/fzf.vim
set rtp+=/usr/local/opt/fzf

" Open fzf with preview on the top and consuming 60% of the vertical window
" space
let g:fzf_preview_window = ['up:60%']

syntax enable
colorscheme jellybeans

" Enable the mouse
if has('mouse')
  set mouse=a
endif

"   Search file names in cwd using fzf
nmap <leader>; :Files<CR>
"   Search file contents in cwd using rg+fzf
nmap <leader>f :Ag<SPACE>
"   Search current buffer contents using rg+fzf
nmap <leader>l :Telescope current_buffer_fuzzy_find<CR>
"   Search open buffers using fzf
nmap <leader>b :Buffers<CR>
"   Search for word under cursor
nmap <leader>s :Ag<SPACE><c-r>=expand("<cword>")<cr><CR>
"   Live-search in cwd using telescope
nmap <leader>g :Telescope live_grep<CR>
"   Search vars, etc.
nmap <leader>t :Telescope treesitter<CR>
"   Toggle Vista (tagbar)
nmap <F8> :Vista!!<CR>

nmap n <Plug>(highlight-current-n-n)
nmap N <Plug>(highlight-current-n-N)

nmap <leader>y :lua require('neoclip.fzf')()<CR>

" From: https://github.com/neoclide/coc.nvim
" Required for coc.nvim popup completion to work
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" End From: https://github.com/neoclide/coc.nvim

let g:vista_default_executive = 'nvim_lsp'
let g:vista_fzf_preview = ['right:50%']

" Open files to last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
  au VimLeave * call system("tmux rename-window zsh")
  " Close vista pane if it's the only thing left open
  au BufEnter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
endif

augroup ClearSearchHL
  autocmd!
  autocmd CmdlineEnter /,\? set hlsearch
  autocmd CmdlineLeave /,\? set nohlsearch
  autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
augroup END
