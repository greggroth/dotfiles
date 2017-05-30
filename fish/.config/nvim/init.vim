" {{{ Neobundle Init
set encoding=utf8
set backspace=2
let mapleader = ","

call plug#begin('~/.vim/plugged')
" }}}

" {{{ Basic Bundles
Plug 'Shougo/vimproc.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

nmap <C-p> :FZF --no-mouse<CR>

Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-css-color'
Plug 'robbles/logstash.vim'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-go', { 'do': 'make'}

vmap <Enter> <Plug>(EasyAlign)
" }}}


" let g:deoplete#enable_at_startup = 1

" {{{ Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'

let g:airline_theme='base16_eighties'
let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
" }}}

" {{{ GoLang
Plug 'fatih/vim-go'

let g:go_auto_type_info = 1
let g:go_term_enabled = 1
let g:go_term_mode = "split"
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>i <Plug>(go-info)
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
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

let g:rspec_command = "tabnew|te bin/rspec {spec}"
let g:rspec_runner = "os_x_iterm"

" let g:vroom_use_spring=0
" let g:vroom_use_binstubs=1
" let g:vroom_cucumber_path='rspec'

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>
" }}}

" {{{ Syntax Highlighting
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'slim-template/vim-slim'
Plug 'elzr/vim-json'
" Plug 'dag/vim-fish'

" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
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
set completeopt=menu
" }}}

" {{{ Clojure settings
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1
" }}}

" {{{ Movement Shortcuts
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

nnoremap @@x :%!xmllint --format --recover -<CR>
