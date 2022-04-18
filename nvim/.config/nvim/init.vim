" {{{ Neobundle Init
set encoding=utf8
set backspace=2
let mapleader = ","
let maplocalleader = "\\"
let g:netrw_liststyle= 3

call plug#begin('~/.local/share/nvim/plugged')
" }}}

" {{{ Basic Bundles
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nmap <C-p> :FZF --no-mouse<CR>

Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'google/vim-searchindex'

let g:deoplete#enable_at_startup = 1
let deoplete#tag#cache_limit_size = 5000000

vmap <Enter> <Plug>(EasyAlign)
" }}}

" {{{ Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'

let g:airline_theme='base16_eighties'
let g:airline_left_sep=''
let g:airline_right_sep=''
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

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
" }}}

" {{{ Ruby/Rails
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'coffee', 'javascript'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'haml', 'eruby'] }
" Plug 'tpope/vim-cucumber'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
" Plug 'janko-m/vim-test'

Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim', { 'branch': 'main' }

let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
" vim-rspec mappings
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" let g:test#preserve_screen = 1
" map <Leader>r :TestFile<CR>
" map <Leader>R :TestNearest<CR>
" map <Leader>c :split term://bin/rails c<CR>
" }}}

" {{{ Syntax Highlighting
Plug 'kchmck/vim-coffee-script'
" Plug 'slim-template/vim-slim'
Plug 'elzr/vim-json'
Plug 'aklt/plantuml-syntax'

Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
autocmd FileType org setlocal nowrap

Plug 'chrisbra/csv.vim'

Plug 'w0rp/ale' " Linting
" let g:ale_fix_on_save = 1
" let g:ale_fixers = {
" \  'ruby': [ 'rubocop', 'remove_trailing_lines' ]
" \}
" }}}

" {{{ Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

set signcolumn=yes
set diffopt+=vertical

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
" }}}

" {{{ Install Bundles
call plug#end()
filetype plugin indent on
" }}}

" {{{ Set Theme
silent let g:seoul256_background = 234
silent colorscheme seoul256
set laststatus=2
" }}}

" {{{ Line Numbers
set number
set relativenumber
" }}}

" {{{ Terminal Mode
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>
au TermOpen * setlocal nonumber norelativenumber
" }}}

" {{{ Windows/Panes
" sane split directions
set splitright
set splitbelow

hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" Terminal mode:
tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l
" Insert mode:
inoremap <M-h> <Esc><c-w>h
inoremap <M-j> <Esc><c-w>j
inoremap <M-k> <Esc><c-w>k
inoremap <M-l> <Esc><c-w>l
" Visual mode:
vnoremap <M-h> <Esc><c-w>h
vnoremap <M-j> <Esc><c-w>j
vnoremap <M-k> <Esc><c-w>k
vnoremap <M-l> <Esc><c-w>l
" Normal mode:
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
" }}}

" {{{ Misc
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
set complete+=kspell
set complete=.,w,b,u,U,t,i,d
set wildmode=longest,list:longest
set omnifunc=syntaxcomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
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

" {{{ Bracket to `fetch`
function! BracketToFetch()
  normal! dd
  normal! P
  .s/\v\[([^\]]*)\]/.fetch(\1)/
  normal ==
endfunction
command! BracketToFetch :call BracketToFetch()
map <leader>b :BracketToFetch<cr>
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

command! Standup edit ~/CloudStation/Notes/Stitchfix/standup.org | normal G
