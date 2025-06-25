set nocompatible              " be iMproved
filetype off                  " required!

call plug#begin('~/.vim/plugged')
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'kien/ctrlp.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'milkypostman/vim-togglelist'
Plug 'itchyny/lightline.vim'
Plug 'markonm/traces.vim'
Plug 'lervag/vimtex'
Plug 'garbas/vim-snipmate'
call plug#end()

:imap <C-J> <Plug>snipMateNextOrTrigger

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

set wildignore+=*/vendor,*/vendor/*,*.png,*.jpg,*.gif,build/*,node_modules/*,*.ttf,*/node_modules/*,*/build/*,*/target,*/target/*


let NERDTreeIgnore=['node_modules', 'vendor', 'target', 'build']

" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" perf stuff
:set lazyredraw
:set ttyfast
:set synmaxcol=128
:set re=1
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set nocursorline
set nocursorcolumn
"set relativenumber
set cmdheight=1
set switchbuf=useopen
set showtabline=4
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
set list
set listchars=tab:⋅\ ,extends:#,trail:⋅,nbsp:⋅
" Enable highlighting for syntax
syntax on
syntax sync minlines=200

filetype plugin indent on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType go setlocal omnifunc=
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 
:set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
nnoremap <leader>vb :grep! -Q '<c-r><c-w>'<cr>:cw<cr><cr>
nnoremap <leader>vv :grep! "\b<c-r><c-w>\b"<cr>:cw<cr><cr>

nnoremap <leader>c :nohls<cr>

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>vf :Ag<SPACE>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <c-c> <esc>

nnoremap <leader><leader> <c-^>
nnoremap <leader>s :call OpenSplit()<cr>

function! OpenSplit()
  normal! ␗v
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>n :bn<cr>
map <leader>N :bp<cr>

map <leader>f :CtrlP<cr>
map <leader>F :CtrlPMRU<cr>
map <leader>t :NERDTreeToggle<CR>
map <leader>ide :NERDTreeToggle<CR><c-w>l :bel term<CR> <c-w>k
map <leader>e yy <c-w>j <c-c> <c-w>""<cr> <c-w>k :nohl<cr>
map <leader>T :NERDTreeFind<CR>
map <leader>ust :set softtabstop=2 <bar> :set shiftwidth=2 <bar> :set tabstop=2<cr>
map <leader>et :set expandtab!

inoremap <Nul> <C-x><C-o>
vnoremap . :normal .<CR>
imap <C-b> <CR><Esc>O

set clipboard=unnamedplus
nnoremap <leader>w :w<cr>

set encoding=utf-8
