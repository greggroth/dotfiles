set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-repeat'
Bundle 'mileszs/ack.vim'
Bundle 'benmills/vimux'
Bundle 'godlygeek/tabular'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'kana/vim-arpeggio'
Bundle 'tpope/vim-commentary'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'

" Ruby stuff
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'skalnik/vim-vroom'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-cucumber'

" Pretty colors
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/vim-tomorrow-theme'

" Syntax Highlighting
Bundle 'vim-scripts/VimClojure'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-haml'
Bundle 'groenewege/vim-less'
Bundle 'jtratner/vim-flavored-markdown.git'
Bundle 'tpope/vim-markdown'
Bundle 'bbommarito/vim-slim'

" Syntax checker
Bundle 'scrooloose/syntastic'

" Git
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'

set encoding=utf8
set shell=/bin/sh

" Colorscheme
syntax enable
filetype plugin indent on
colorscheme Tomorrow-Night

" Diff Highlighting
exe "hi! DiffAdd ctermbg=28"
exe "hi! DiffChange ctermbg=220"
exe "hi! DiffDelete ctermbg=88 ctermfg=Cyan"
exe "hi! DiffText ctermbg=53"

" GitGutter Shortcuts
nnoremap gu :GitGutterPrevHunk<CR>
nnoremap gn :GitGutterNextHunk<CR>

" Remap leader to comma
let mapleader = ","

" sane split directions
set splitright
set splitbelow

" set the terminal's title
set title
autocmd BufEnter * let &titlestring = expand("%:t")

" better command completion
set wildmenu
" set complete=.,b,u,]
" set wildmode=longest,list:longest
" set completeopt=menu,preview


" Clojure settings
let vimclojure#HighlightBuiltins=1 
let vimclojure#ParenRainbow=1

" auto load changed files
set autoread

" set the terminal's title
set title

" List chars
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.

" Vertical/horizonal split shortcuts
nnoremap gs <C-w>v
nnoremap gd :sp<CR>

" opens the associated Rails file (test/class, etc.) in a vertical split
nnoremap <leader>y <C-w>v<C-w>l:A<cr>

" moving among splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resizeing splits
nnoremap <leader>+ :res +10<CR>
nnoremap <leader>- :res -10<CR>

" save/quits
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>

" leader shortcuts
map <leader>vi :e ~/.vimrc<CR>
map <leader>gb :Gblame<CR>

" tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" add ruby comments
autocmd FileType ruby set commentstring=#\ %s

" convert view to html
map <leader>ht :runtime! syntax/2html.vim<CR>

" open CtrlP
let g:ctrlp_map = '<leader>t'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'

" quick buffer switching
nnoremap <F6> :buffers<CR>:buffer<Space>

" status bar
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" More sane searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" clear highlights
nnoremap <leader>/ :noh<CR>

set novisualbell  " No blinking .
set noerrorbells  " No noise.

" ViMux Shortcuts
" Prompt for a command to run
" map <leader>p :PromptVimTmuxCommand<CR>
" Run last command executed by RunVimTmuxCommand
map <leader>l :RunLastVimTmuxCommand<CR>
" Inspect runner pane
map <leader>i :InspectVimTmuxRunner<CR>
" Close all other tmux panes in current window
map <leader>x :CloseVimTmuxPanes<CR>
" Interrupt any command running in the runner pane
" map <leader>s :InterruptVimTmuxRunner<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
if !col || getline('.')[col - 1] !~ '\k'
  return "\<tab>"
else
  return "\<c-p>"
endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
set complete=.,b,u,]

" backups
set nobackup
set nowritebackup
set tags=./tmp/tags,./tags,tags
set backupdir=~/.vim/_backup
set directory=~/.vim/_tmp

" search/replace word under cursor
nnoremap <C-a> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a{ :Tabularize /{<CR>
vmap <Leader>a{ :Tabularize /{<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a\| :Tabularize /\|<CR>
vmap <Leader>a\| :Tabularize /\|<CR>

" Use system clipboard
set clipboard=unnamed

" <leader><leader> toggles between files
nnoremap <leader><leader> <c-^>

" Cursor highlighting
set cursorcolumn
set cursorline

" Scrolling
set scrolloff=8        " Number of lines from vertical edge to start scrolling
set sidescrolloff=15   " Number of cols from horizontal edge to start scrolling

" local variable -> let() { ... }
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

function! MoveLine(open_motion, post_motion)
  let cols=col('.')
  execute "normal! D" . a:open_motion

  let next_cols=col('.')
  let delta_cols=cols-next_cols

  if(delta_cols > 0)
    execute "normal! " . delta_cols . "A "
  endif

  execute "normal! p" . a:post_motion
endfunction

function! GistLinks()
  :%s/\vhttps:\/\/gist\.github\.com\/([0-9a-z]*)/{% gist \1 %}/g
endfunction
:command! GistLinks :call GistLinks()

augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Markdown preview
nnoremap <leader>mm :silent !open -a Marked.app '%:p'<cr>

" Folding shorcuts
nnoremap <space> za

" Press jk together for <esc>
call arpeggio#load()
Arpeggio inoremap jk  <Esc>

python import sys; sys.path.append("/usr/local/lib/python2.7/site-packages/")
python from powerline.vim import VimPowerline
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
