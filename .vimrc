" Be iMproved
set nocompatible

" Turn of file type detection until plugins are loaded
filetype off

" Load plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Enable file type detection
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 50 lines of command line history
set history=50  

" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Show line numbers
set number

" Make cscope work.
" Ctrl+\ -> s : show references of symbol
set runtimepath^=~/.vim/bundle/cscope_maps

" Spaces > Tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Preserve padding of at least 10 lines between cursor and top or bottom of the window
set scrolloff=10

" Haven't been bitten by not having an undo file yet...and they're really annoying.
set noundofile

" fzf in vim!
set rtp+=/usr/local/opt/fzf

" Tell ack.vim to use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Plugin settings
colorscheme jellybeans
let g:airline_theme='base16_bright'
let g:limelight_conceal_ctermfg = 'gray'

" Display >--- for tabs
set listchars=tab:>-
set list

" Normal mode keybinds
nmap <F6> :Limelight!!<CR>
nmap <F7> :Goyo<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :set list!<CR>
nmap ; :Files<CR>
nmap f :Ag 
nmap l :Lines<CR>
nmap b :Buffers<CR>
nmap m :MultipleCursorsFind<SPACE>

" Don't use Ex mode, use Q for formatting line width
map Q gq

" Open files to last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

