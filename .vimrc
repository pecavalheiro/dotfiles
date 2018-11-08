set nocompatible                              " be iMproved, required
filetype off                                  " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

let mapleader = ","
set t_Co=256
set showmode                                  " Shows current mode (insert, visual, replace)
syntax on                                     " Enables syntax
set number                                    " Shows line numbers
set ruler                                     " Shows line and column numbers
set list                                      " Diffs between tabs, spaces and trailing blanks
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Shows hidden characters
colorscheme railscasts                        " So cosy
set history=200                               " History limit
set undolevels=200                            " Undo levels limit
set timeoutlen=400                            " Timeout for leader key
set visualbell                                " Disable annoying sound
filetype on                                   " Enable filetype detection
filetype indent on                            " Load indent file for the current filetype
filetype plugin on                            " Enable filetype-specific plugins
set expandtab                                 " Tabs to spaces
set tabstop=2 softtabstop=2                   " Tab width
set shiftwidth=2                              " >>, << and == width
set autoindent                                " Copy the indentation from the previous line
set smartindent
set diffopt+=vertical                         " Vertical Gdiff
set hlsearch                                  " Highlight matches.
set incsearch                                 " Show search matches as you type
set autoread                                  " Auto reload files when externally modified.
set title                                     " Sets the title of the window
set pastetoggle=<F2>                          " Enables paste mode
set tags=tags                                 " ctags

" Enter clears search highlight
nmap <CR> :nohlsearch<CR>

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '

" Red column at position 80
highlight ColorColumn ctermbg=88 guibg=#d70000
set colorcolumn=80,100

" Highlights text over 100 columns
"au BufWinEnter * let w:m1=matchadd('Search', '\%<101v.\%>77v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)

" Grey cursor line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Default mappings
map <leader>s <ESC>:w<CR>
map <leader>q <ESC>:q<CR>
map <leader>bp <ESC>Obinding.pry<ESC>,s,l
" Tabs mapping
map <Leader>tt <ESC>:tabnew<CR>
" Rubocop autofix
map <Leader>rua <ESC>:RuboCop -a<CR>
" Macro shortcut
map <Leader>m @
" ,. to browse generated CTags
nnoremap <leader>. :CtrlPTag<cr>
" Shortcut for Ack
map <Leader>ag <ESC>:Ack 
" Unwanted features
map q: <NOP>
noremap Q <NOP>
" Disable arrows and home keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>
noremap <Home> <NOP>
noremap <End> <NOP>
noremap <Del> <NOP>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_max_files = 0

" RSpec.vim mappings
map <Leader>t :TestFile<CR>
map <Leader>a :TestSuite<CR>
map <Leader>n :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>g :TestVisit<CR>
map <Leader>ss <ESC>:w<CR>:TestFile<CR>
"let g:rspec_command = "!clear && bundle exec rspec --fail-fast {spec}"
"let test#elixir#exunit#executable = 'clear && iex -S mix test --trace'

" NERDTree in ctrl + n
map <C-n> :NERDTreeToggle<CR>

" Close Vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ruby Autocomplete Buffer
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Ctags for ruby and javascript
:nnoremap <F5> :! ctags -R --languages=ruby,javascript --exclude=.git --exclude=node_modules --exclude=log . %<CR>

" Remove trailing spaces with F6
:nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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

" make backspace work like most other programs
set backspace=2

" Highlights nginx.conf files
autocmd BufEnter nginx.conf* if &filetype == "" | setlocal ft=nginx | endif

" Idents xml files with xmllink (needs libxml2-utils)
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Add vim-fugitive to status line
set statusline+=%{fugitive#statusline()}

" Prevents Vim from scrolling when splitting the window horizontally.
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

" Use eslint for javascript linting
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'yarn eslint --'

" GitGutter workaround for updating buffer
autocmd BufWritePost * GitGutter

" Disable ALE auto lint
let g:ale_lint_on_text_changed = 'never'
map <Leader>ale <ESC>:ALELint<CR>

"  Disable vim-bookmarks when NERDTree is open
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

if &term =~ '256color'
    set t_ut=
endif
