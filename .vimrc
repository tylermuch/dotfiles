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

" Highlight search results
set hlsearch

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 1000 lines of command line history
set history=1000

" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Enable 'hybrid' line number mode
set number relativenumber
set nu rnu

" When a buffer is brought to foreground, remember undo history and marks
set hidden

" Highlight dynamically as pattern is typed
set incsearch

" Disable error bells
set noerrorbells

" Don't reset cursor to start of line when moving around
set nostartofline

" Don't redraw when we don't have to
set lazyredraw

" Send more characters at a given time. Makes scrolling smoother
set ttyfast

" Restore buffer list and marks for 9999 files, registers up to 512Kb are remembered
set viminfo=%,'9999,s512,n~/.vim/viminfo

" Use visual bell instead of audible bell
set visualbell

" Make cscope work.
" Ctrl+\ -> s : show references of symbol
set runtimepath^=~/.vim/bundle/cscope_maps

" Spaces > Tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Preserve padding of at least 5 lines between cursor and top or bottom of the window
set scrolloff=5

" Haven't been bitten by not having an undo file yet...and they're really annoying.
set noundofile

" fzf in vim!
set rtp+=/usr/local/opt/fzf

" Tell ack.vim to use ag instead of ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" Plugin settings
colorscheme jellybeans
let g:airline_theme='base16_bright'
let g:limelight_conceal_ctermfg = 'gray'
set term=screen-256color

" Display >--- for tabs
set listchars=tab:>-
set list

" Normal mode keybinds
"   Toggle highlighting tabs
nmap <F5> :set list!<CR>
"   Toggle Tagbar
nmap <F8> :TagbarToggle<CR>
"   Search file names in cwd using fzf
nmap <leader>; :Files<CR>
"   Search file contents in cwd using rg+fzf
nmap <leader>f :Ag<SPACE>
"   Search current buffer contents using rg+fzf
nmap <leader>l :Lines<CR>
"   Search open buffers using fzf
nmap <leader>b :Buffers<CR>
"   Place multiplecursor at start of each search result
nmap <leader>m :MultipleCursorsFind<SPACE>
"   Go to previous buffer
nmap <leader><TAB> :bprevious<CR>
"   Go to next buffer
nmap <leader>q :bnext<CR>
"   Search for word under cursor
nmap <leader>s :Ag<SPACE><c-r>=expand("<cword>")<cr><CR>

" Don't use Ex mode, use Q for formatting line width
map Q gq

" Use vertical cursor in insert mode
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

let g:fzf_preview_window = ['up:60%']

" Open files to last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
  au VimLeave * call system("tmux setw automatic-rename")
endif

" From: https://gist.github.com/amitab/cd051f1ea23c588109c6cfcb7d1d5776
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

nnoremap <silent> <Leader>cc :call Cscope('1', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cd :call Cscope('2', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ce :call Cscope('3', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cf :call Cscope('4', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cg :call Cscope('6', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ci :call Cscope('7', expand('<cword>'))<CR>
nnoremap <silent> <Leader>cs :call Cscope('8', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ct :call Cscope('9', expand('<cword>'))<CR>

nmap <C-]> <Plug>(fzf_tags)
