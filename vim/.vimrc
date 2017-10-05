" {{{ Neobundle Init
set shell=/usr/local/bin/bash\ -l
" set shellcmdflag=-l
" set shell=/usr/local/bin/zsh
set encoding=utf8
set backspace=2
let mapleader = ","

call plug#begin('~/.vim/plugged')
" }}}

" {{{ Basic Bundles
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/vimproc.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

nmap <C-p> :FZF --no-mouse<CR>
" let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules)$'

Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'
Plug 'henrik/vim-indexed-search'
Plug 'ap/vim-css-color'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

vmap <Enter> <Plug>(EasyAlign)

" }}}

" {{{ Theming
Plug 'bling/vim-airline'
Plug 'junegunn/seoul256.vim'

let g:airline_theme='luna'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
" }}}

" {{{ GoLang
Plug 'fatih/vim-go'
" }}}

" {{{ Ruby/Rails
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-cucumber'
Plug 'greggroth/vim-cucumber-folding'
Plug 'matchit.zip'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'greggroth/vim-rspec'

let g:rspec_command = "!bin/rspec {spec}"
let g:rspec_runner = "os_x_iterm"

" let g:vroom_use_spring=0
" let g:vroom_use_binstubs=1
" let g:vroom_cucumber_path='rspec'

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>
" }}}

" {{{ Haskell
Plug 'wlangstroth/vim-haskell'
Plug 'vim-scripts/Superior-Haskell-Interaction-Mode-SHIM'
" }}}

" {{{ Syntax Highlighting
Plug 'vim-scripts/VimClojure'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-haml'
Plug 'groenewege/vim-less'
Plug 'slim-template/vim-slim'
Plug 'elzr/vim-json'
Plug 'dag/vim-fish'
" Plug 'JuliaLang/julia-vim'
Plug 'nneal/vim-teaspoon'

Plug 'scrooloose/syntastic'
" }}}

" {{{ Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

set diffopt+=vertical

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
" }}}

" {{{ Install Bundles
call plug#end()
filetype plugin indent on
" }}}

" {{{ Set Theme
set t_Co=256
let g:seoul256_background = 235
colorscheme seoul256
set laststatus=2
" }}}

" {{{ Line Numbers
set number
set relativenumber
" }}}

" {{{ Misc
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
set smartindent

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Disable all bells
set noeb vb t_vb=

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
set foldmethod=indent
set foldlevelstart=99 " open all folds by default
nnoremap <space> za

" Use <C-l> to leave insert mode
imap <C-l> <Esc><CR>
" }}}

" {{{ Command completion
set path=**
set suffixesadd=.rb,.h,.m
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

function! Ag(term)
  silent execute 'grep ' . a:term
  redraw!
  copen
endfunction
command! -nargs=1 -complete=file Ag call Ag(<f-args>)

" Search using ack instead of grep.  Results are loaded into the quickfix.
set grepprg=ag\ --nocolor\ --nogroup\ --column
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


" {{{ cscope
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
  endif
  set csverb
endif
" }}}

" {{{ folding
nnoremap zh zMzvzczO  " Fold everything except for the current line
" }}}

syntax enable

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

nnoremap <leader>a :Ag <C-r><C-w><CR>

" Prevent YouCompleteMe from always popping up
let g:ycm_auto_trigger = 0
