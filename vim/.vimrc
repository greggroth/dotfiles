set shell=/bin/sh\ -l

if has('vim_starting')
set nocompatible               " Be iMproved

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'mileszs/ack.vim'
" NeoBundle 'rking/ag.vim'
NeoBundle 'benmills/vimux'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'bling/vim-airline'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'jnwhiteh/vim-golang'

" Docbook Editing
NeoBundle 'sukima/vim-docbk'
NeoBundle 'othree/xml.vim'
NeoBundle 'msanders/snipmate.vim'

hi link docbkKeyword String
hi link xmlTag Identifier
hi link xmlTagEnd xmlTag

" Ruby stuff
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'tpope/vim-rvm'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'greggroth/vim-cucumber-folding'
NeoBundle 'matchit.zip'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nelstrom/vim-textobj-rubyblock'

" Pretty colors
NeoBundle 'junegunn/seoul256.vim'

" Syntax Highlighting
NeoBundle 'vim-scripts/VimClojure'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-haml'
NeoBundle 'groenewege/vim-less'
NeoBundle 'jtratner/vim-flavored-markdown.git'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'elzr/vim-json'
NeoBundle 'dag/vim-fish'

" Syntax checker
NeoBundle 'scrooloose/syntastic'

" Git
NeoBundle 'mhinz/vim-signify'
NeoBundle 'tpope/vim-fugitive'

" Required:
filetype plugin indent on
NeoBundleCheck

set encoding=utf8

set number
set relativenumber

" Colorscheme
set t_Co=256
syntax enable
colorscheme seoul256

" Remap leader to comma
let mapleader = ","

" sane split directions
set splitright
set splitbelow

" set the terminal's title
set title
" autocmd BufEnter * let &titlestring = expand("%:t")

"Signify shortcuts
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" better command completion
set path=**
set wildmenu
set complete=.,b,u,]
set wildmode=longest,list:longest
" set wildmode=full
set completeopt=menu,preview



" Clojure settings
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

" auto load changed files
set autoread

" set the terminal's title
set title

" List chars
set list listchars=tab:→\ ,trail:●

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
noremap <leader>q :x<CR>

" autosave
au BufLeave * :up

" fugitive shortcuts
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit --verbose<CR>
map <leader>gw :Gwrite<CR>

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
set foldmethod=syntax
set foldlevelstart=99 " open all folds by default
nnoremap <space> za

" Press jk together for <esc>
call arpeggio#load()
Arpeggio inoremap jk  <Esc>

" python import sys; sys.path.append("/usr/local/lib/python2.7/site-packages/")
" python from powerline.vim import VimPowerline
" source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim

let g:airline_theme='ubaryd'
let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : ''}

let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '|',
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '}

" Gem tags
" set tags+=gem_tags


" vertical resize as 'Z<num><cr>', similar to internal 'z<num><cr>' command
nn Z :set opfunc=Zop<cr>g@
fu! Zop(arg)
    exe 'vert resize ' . v:count
endf
