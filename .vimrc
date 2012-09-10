set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'skwp/vim-rspec'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-repeat'
Bundle 'skalnik/vim-vroom'
Bundle 'tpope/vim-rvm'
Bundle 'mileszs/ack.vim'
Bundle 'bbommarito/vim-slim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'kchmck/vim-coffee-script'
Bundle 'benmills/vimux'
Bundle 'nelstrom/vim-markdown-preview'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'godlygeek/tabular'

set encoding=utf8
set shell=/bin/sh

" Colorscheme
syntax enable
filetype plugin indent on
colorscheme solarized
set background=dark

" Line Numbers
set number

" Remap leader to comma
let mapleader = ","

" sane split directions
set splitright
set splitbelow

" set the terminal's title
set title

" <leader>w opens a vertical split window and switches to it
nnoremap <leader>w <C-w>v<C-w>l

" <leader>t opens the associated Rails file (test/class, etc.) in a vertical split
nnoremap <leader>t <C-w>v<C-w>l:A<cr>

" moving among splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" add ruby comments
autocmd FileType ruby set commentstring=#\ %s

" open CtrlP
let g:ctrlp_map = '<leader>t'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'

" quick buffer switching
nnoremap <F6> :buffers<CR>:buffer<Space>

" status bar
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set nocompatible   " Disable vi-compatibility
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

" Vim-Vroom options
let g:vroom_use_vimux = 1

" ViMux Shortcuts
" Prompt for a command to run
" map <leader>p :PromptVimTmuxCommand<CR>
" Run last command executed by RunVimTmuxCommand
" map <leader>l :RunLastVimTmuxCommand<CR>
" Inspect runner pane
" map <leader>i :InspectVimTmuxRunner<CR>
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
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" open NERDTree
map <leader>p :NERDTree<CR>

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
