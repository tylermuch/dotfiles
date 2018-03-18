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

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 50 lines of command line history
set history=50  

" Don't use Ex mode, use Q for formatting line width
map Q gq

" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors 
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
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

" Highlight the line the cursor is on
set cursorline

" fzf in vim!
set rtp+=/usr/local/opt/fzf

" Tell ack.vim to use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Theme settings
colorscheme jellybeans
let g:airline_theme='base16_bright'

" Display >--- for tabs
set listchars=tab:>-
set list

" Keybindings
nmap <F8> :TagbarToggle<CR>
nmap <F9> :set list!<CR>
nmap ; :Files<CR>
nmap \f :Ack! 

" Open files to last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
