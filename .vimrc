let mapleader = ","
set t_Co=256
set showmode
syntax on
set number
set ruler
colorscheme sift
set background=dark
set history=100
set visualbell
set nocompatible              " be iMproved, required
filetype on                   " Enable filetype detection
filetype indent on 	      " load indent file for the current filetype
filetype plugin on 	      " Enable filetype-specific plugins

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set smartindent
set autoindent

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

" Open NERDTree when no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if NERDTREE is the only window left open
