filetype off
set nocompatible

" Install vim-plug if it's missing. Need curl(1) though.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" External plugins
" vim-plug set up
call plug#begin('~/.vim/plugged')

Plug 'luochen1990/rainbow'

Plug 'xolox/vim-misc'
Plug 'Valloric/MatchTagAlways'

" Display indention-levels as characters.
Plug 'Yggdroot/indentLine'

" Show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-dispatch'

Plug 'ervandew/supertab'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'google/vim-ft-bzl'

Plug 'junegunn/vim-peekaboo'

Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'

Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'

Plug 'vimwiki/vimwiki'

Plug 'sheerun/vim-polyglot'

Plug 'itchyny/lightline.vim'

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
else
  call plug#end()
endif

" Allow editing of crontab files.
set backupskip=/tmp/*,/private/tmp/*

" % for tags
source $VIMRUNTIME/macros/matchit.vim

set backspace=indent,eol,start

function EnableNormalTextChrome()
  " indentLine
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#09AA08'
  let g:indentLine_char = '│'
  " Add line numbers to side
  set number
  " Show tabs and eols
  set list!
  set listchars=tab:▸\ ,eol:¬
endfunction

function DisableNormalTextChrome()
  let g:indentLine_char = ''
  set nonumber
  set nolist!
endfunction

call EnableNormalTextChrome()

let mapleader = "\<SPACE>"

" copy file path
nmap ,cp :let @+=expand("%:p")<CR>

" search settings
set ignorecase
set smartcase

set smarttab
set expandtab

" 80chars by style-guide
set colorcolumn=80

augroup filetype_java
  autocmd!
  autocmd FileType java set colorcolumn=100
augroup END

" Use javascript formatter for json, because the actual json formatter is gross.
autocmd BufNewFile,BufRead *.json set ft=javascript

" nicer tab completion for file accessing
set wildmode=longest,list,full
set wildmenu

" Relative edits.
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"-------------------------------------------------------------------------------
" Color set up.
"-------------------------------------------------------------------------------
syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

set hidden                        " Handle multiple buffers better.
set title                         " Set the terminal's title
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set wildignore=*.o,*.obj,*~       " Stuff to ignore when tab completing
set wildignore+=*/.git/objects/*
set wildignore+=*/.git/refs/*
set wildignore+=*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*,*.so
set wildignore+=*.swp,*.zip

" small tweaks
set ttyfast                       " indicate a fast terminal connection
set tf                            " improve redrawing for newer computers
set nolazyredraw                  " turn off lazy redraw
set shell=/bin/zsh

set visualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set scrolloff=3
set sidescrolloff=7

set splitbelow
set splitright

set sidescroll=1
set mouse-=a
set mousehide
if !has("nvim")
  set ttymouse=xterm2
endif
if exists("+inccommand")
  set inccommand=nosplit
endif

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=/tmp                " Keep swap files in one location
set noswapfile
set timeoutlen=500

set laststatus=2                  " Show the status line all the time

" clear trailing spaces on save
autocmd BufWritePre * kz|:%s/\s\+$//e|'z

"###############################################################################
" Plugins
"###############################################################################

"-------------------------------------------------------------------------------
" vimwiki
"-------------------------------------------------------------------------------

let g:vimwiki_list = [{'path': '~/notes/vimwiki/'}]

"-------------------------------------------------------------------------------
" Ack.vim
"-------------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nmap <M-k>    :Ack! "\b<cword>\b" <CR>
"nmap <Esc>k   :Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  :Ggrep! "\b<cword>\b" <CR>
"nmap <Esc>K   :Ggrep! "\b<cword>\b" <CR>

"-------------------------------------------------------------------------------
" YCM
"-------------------------------------------------------------------------------
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:EclimCompletionMethod = 'omnifunc'

nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Add the ability to GoTo definition under cursor.
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>

nnoremap gp `[v`]

"-------------------------------------------------------------------------------
" SuperTab
"-------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = '<C-n>'

"-------------------------------------------------------------------------------
" fzf
"-------------------------------------------------------------------------------
nnoremap <silent> <Leader><Leader> :FZF -m<CR>

nnoremap <silent> <Leader>s :call fzf#run({ 'tmux_height': winheight('.') / 2, 'sink': 'botright split' })<CR>
nnoremap <silent> <Leader>v :call fzf#run({ 'tmux_width': winwidth('.') / 2, 'sink': 'vertical botright split' })<CR>

function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! BufOpen(e)
  execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '40%'
\ })<CR>

"-------------------------------------------------------------------------------
" lightline
"-------------------------------------------------------------------------------
set laststatus=2
set noshowmode

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
filetype plugin indent on
