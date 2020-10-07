set nocompatible                              " be iMproved, required
filetype off                                  " required

" better organization for Plug
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
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
set history=100                               " History limit
set undolevels=100                            " Undo levels limit
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
set ignorecase                                " Workaround for smartcase
set smartcase                                 " Case sensitive search only when uppercase
" set nowrap                                  " Line wrapping
highlight LineNr ctermfg=darkgrey
set clipboard=unnamed                         " Share clipboard between tmux and vim
set rtp+=~/.fzf

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

" FZF mappings
" fzf by filename
map <C-p> :FZF<CR>
" fzf file content
nnoremap <C-g> :Ag<Cr>

" RSpec.vim mappings
map <Leader>t :TestFile<CR>
map <Leader>a :TestSuite<CR>
map <Leader>n :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>g :TestVisit<CR>
map <Leader>ss <ESC>:w<CR>:TestFile<CR>

" Git mappings
map <Leader>gb <ESC>:Gblame<CR>
map <Leader>cgb <ESC>:q<CR>:Gblame<CR>
map <Leader>cgbi <ESC>:q<CR>:Gblame<CR>i

" NERDTree in ctrl + n
map <C-n> :NERDTreeToggle<CR>

" Show hidden files in CTRLP
let g:ctrlp_show_hidden = 1

" Close Vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ruby Autocomplete Buffer
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

if executable('ripper-tags')
  " Ripper-tags (better ctags for ruby)
  :nnoremap <F5> :! ripper-tags -R --exclude=vendor<CR>
else
  " Ctags for ruby and javascript
  :nnoremap <F5> :! ctags -R --languages=ruby,javascript --exclude=.git --exclude=node_modules --exclude=log . %<CR>
endif

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

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

" Lists all buffers and waits for input
nnoremap <Leader>b :ls<CR>:b<Space>

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" (FZF) Open a new buffer at the bottom
let g:fzf_layout = { 'window': 'botright new' }

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

nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 0
let g:ale_lint_on_insert_leave = 0
map <Leader>ale <ESC>:ALELint<CR>
let g:ale_cache_executable_check_failures = 1

if &term =~ '256color'
    set t_ut=
endif

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Use bin/rubocop instead of rubocop if available
if executable('bin/rubocop')
  let g:vimrubocop_rubocop_cmd = 'bin/rubocop '
endif
