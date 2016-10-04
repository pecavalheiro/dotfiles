let mapleader = ","
set t_Co=256
set showmode
syntax on
set number
set ruler
colorscheme railscasts
set history=100
set timeoutlen=400
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
set diffopt+=vertical             " Vertical Gdiff

set hlsearch                      " Highlight matches.
set autoread                      " Auto reload files when externally modified.

" Enter clears search highlight
nmap <CR> :nohlsearch<CR>

highlight ColorColumn ctermbg=235 guibg=#2c2d27
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
map 44 $
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

" ,. to browse generated CTags
nnoremap <leader>. :CtrlPTag<cr> 

map <Leader>ss <ESC>:w<CR>:call RunCurrentSpecFile()<CR>
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if NERDTREE is the only window left open

" Ruby Autocomplete Buffer
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Highlight all occurrences of current word.
:nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR> 

" Don't overwrite register when pasting
" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1