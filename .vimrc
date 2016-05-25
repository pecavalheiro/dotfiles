let mapleader = ","
set t_Co=256
set showmode
syntax on
set number
set ruler
colorscheme railscasts
" set background=dark
set history=100
set visualbell
set nocompatible              " be iMproved, required
filetype on                   " Enable filetype detection
filetype indent on 	      " load indent file for the current filetype
filetype plugin on 	      " Enable filetype-specific plugins
set guifont=Source\ Code\ Pro

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set cindent
set smartindent
set autoindent

set hlsearch                      " Highlight matches.

" Enter clears search highlight
nmap <CR> :nohlsearch<CR>

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Default mappings
map <leader>s <ESC>:w<CR>
map <leader>q <ESC>:q<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>
noremap <Home> <NOP>
noremap <End> <NOP>
noremap <Del> <NOP>

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = "!clear && rspec --fail-fast {spec}"

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if NERDTREE is the only window left open
