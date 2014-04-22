" {{{ Neobundle Init
set shell=/bin/sh\ -l

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" {{{ Basic Bundles
NeoBundle 'kien/ctrlp.vim'

let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'

NeoBundle 'tpope/vim-repeat'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-dispatch'
" }}}

" {{{ Theming
NeoBundle 'bling/vim-airline'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'junegunn/seoul256.vim'

set t_Co=256
syntax enable
colorscheme seoul256
set laststatus=2

let g:airline_theme='ubaryd'
let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y', '#h'],
      \'z'    : ''}

let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '|',
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '}
" }}}

" {{{ GoLang
NeoBundle 'jnwhiteh/vim-golang'
" }}}

" {{{ DocBook
NeoBundle 'sukima/vim-docbk'
NeoBundle 'othree/xml.vim'
NeoBundle 'msanders/snipmate.vim'

hi link docbkKeyword String
hi link xmlTag Identifier
hi link xmlTagEnd xmlTag
" }}}

" {{{ Ruby/Rails
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'greggroth/vim-cucumber-folding'
NeoBundle 'matchit.zip'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
" }}}

" {{{ Syntax Highlighting
NeoBundle 'vim-scripts/VimClojure'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-haml'
NeoBundle 'groenewege/vim-less'
NeoBundle 'jtratner/vim-flavored-markdown.git'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'elzr/vim-json'
NeoBundle 'dag/vim-fish'

NeoBundle 'scrooloose/syntastic'
" }}}

" {{{ Git
NeoBundle 'mhinz/vim-signify'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
" }}}

" {{{ Install Bundles
filetype plugin indent on
NeoBundleCheck
" }}}

" {{{ Line Numbers
set number
set relativenumber
" }}}

" {{{ Misc
set encoding=utf8
let mapleader = ","

" sane split directions
set splitright
set splitbelow

" set the terminal's title
set title

" Improve performance by lazy-drawing
set lazyredraw

" auto load changed files
set autoread

" List chars
set list listchars=tab:→\ ,trail:●

" autosave
set autowrite

" tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

set novisualbell  " No blinking .
set noerrorbells  " No noise.

set nobackup
set nowritebackup
set tags=./tmp/tags,./tags,tags
set backupdir=~/.vim/_backup
set directory=~/.vim/_tmp

" Use system clipboard
set clipboard=unnamed

" Cursor highlighting
set cursorcolumn
set cursorline

" Scrolling
set scrolloff=8        " Number of lines from vertical edge to start scrolling
set sidescrolloff=15   " Number of cols from horizontal edge to start scrolling

" Folding shorcuts
set foldmethod=syntax
set foldlevelstart=99 " open all folds by default
nnoremap <space> za
" }}}

" {{{ Command completion
set path=**
set wildmenu
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview
" }}}

" {{{ Clojure settings
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1
" }}}

" {{{ Movement Shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>+ :res +10<CR>
nnoremap <leader>- :res -10<CR>
" }}}

" {{{ Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

nnoremap <leader>/ :noh<CR>
" }}}

" {{{ Promote to let
function! PromoteToLet()
  normal! dd
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
command! PromoteToLet :call PromoteToLet()
map <leader>p :PromoteToLet<cr>
" }}}
