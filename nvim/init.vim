filetype off

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'vim-airline/vim-airline'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
call plug#end()

lua require('init')

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

filetype plugin indent on

" Line numbers
set number

" Disable error bells
set noerrorbells

" Spaces > Tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Preserve padding of at least 5 lines between cursor and top or bottom of the window
set scrolloff=5

" Haven't been bitten by not having an undo file yet...and they're really annoying.
set noundofile

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
let g:airline_theme='base16_bright'

" Enable the mouse
if has('mouse')
  set mouse=a
endif

"   Search file names in cwd using fzf
nmap <leader>; :Files<CR>
"   Search file contents in cwd using rg+fzf
nmap <leader>f :Ag<SPACE>
"   Search current buffer contents using rg+fzf
nmap <leader>l :Lines<CR>
"   Search open buffers using fzf
nmap <leader>b :Buffers<CR>
"   Search for word under cursor
nmap <leader>s :Ag<SPACE><c-r>=expand("<cword>")<cr><CR>

" Live grep
nmap <leader>g :Telescope live_grep<CR>

" Open files to last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
  au VimLeave * call system("tmux setw automatic-rename")
  " au Filetype * AnyFoldActivate
endif
