set nocompatible              " be iMproved
filetype off                  " turn off until plugins are loaded

" Load plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Line numbers
set number

set runtimepath^=~/.vim/bundle/cscope_maps

" Spaces > Tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Preserve padding of at least 10 lines between cursor and top or bottom of
" the window
set scrolloff=10

" Haven't been bitten by not having an undo file yet...and they're really
" annoying.
set noundofile

" Highlight the line the cursor is on
set cursorline

" fzf in vim!
set rtp+=/usr/local/opt/fzf

" Tell ack.vim to use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

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
