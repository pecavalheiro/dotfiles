set nocompatible " Required
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

let mapleader = ","
set t_Co=256
set showmode
syntax on
set number
set ruler
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
colorscheme railscasts
set history=500
set undolevels=500
set timeoutlen=400
set visualbell
filetype on                   " Enable filetype detection
filetype indent on 	      " load indent file for the current filetype
filetype plugin on 	      " Enable filetype-specific plugins
"set guifont=Source\ Code\ Pro
set guifont=Neep\ 18

set expandtab " Tabs to spaces
set tabstop=2 shiftwidth=2 softtabstop=2
set cindent
set smartindent
set autoindent
set diffopt+=vertical             " Vertical Gdiff

set hlsearch                      " Highlight matches.
set incsearch                     " Show search matches as you type
set autoread                      " Auto reload files when externally modified.
set title
set pastetoggle=<F2>              " Enables paste mode

" Enter clears search highlight
nmap <CR> :nohlsearch<CR>

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '

highlight ColorColumn ctermbg=160 guibg=#d70000
set colorcolumn=80

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Default mappings
map <leader>s <ESC>:w<CR>
map <leader>q <ESC>:q<CR>
map q: <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>
noremap <Home> <NOP>
noremap <End> <NOP>
noremap <Del> <NOP>
noremap Q <NOP>
map <leader>bp <ESC>Obinding.pry<ESC>,s,n
map <leader>us <ESC>:Eunittest<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = "!clear && bundle exec rspec --fail-fast {spec}"

" Tabs mapping
map <Leader>tt <ESC>:tabnew<CR>

" Rubocop autofix
map <Leader>rua <ESC>:RuboCop -a<CR>

" Macro shortcut
map <Leader>m @

" ,. to browse generated CTags
nnoremap <leader>. :CtrlPTag<cr> 

map <Leader>ss <ESC>:w<CR>:call RunCurrentSpecFile()<CR>
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if NERDTREE is the only window left open

" Ruby Autocomplete Buffer
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

if executable('ripper-tags')
" Ripper-tags (better ctags for ruby)
  :nnoremap <F5> :! ripper-tags -R --exclude=log . %<CR> 
else
" Ctags
  :nnoremap <F5> :! ctags -R --languages=ruby --exclude=.git --exclude=log . %<CR> 
endif

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

" Format pasted text automatically
:nnoremap p p=`]

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1

" Use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set backspace=2 " make backspace work like most other programs

autocmd BufEnter nginx.conf* if &filetype == "" | setlocal ft=nginx | endif
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null " idents xml files with xmllink (needs libxml2-utils)

set statusline+=%{fugitive#statusline()}

" Shortcut for Ack
map <Leader>ag <ESC>:Ack 

" Prevents Vim from scrolling when splitting the window horizontally.
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'yarn eslint --'

autocmd BufWritePost * GitGutter " GitGutter workaround for updating buffer
