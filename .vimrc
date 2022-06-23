set nocompatible                              " be iMproved, required
filetype off                                  " required

" better organization for Plug
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

let mapleader = ","
set t_Co=256
set showmode                                  " Shows current mode (insert, visual, replace)
" syntax on                                     " Enables syntax
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
" Rubocop dangerous autofix
map <Leader>ruaa <ESC>:RuboCop -A<CR>
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

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" FZF mappings
" fzf by filename
map <C-p> :FZF<CR>
" fzf file content
nnoremap <C-g> :Rg<Cr>

" vim-test mappings
map <Leader>t :TestFile<CR>
map <Leader>a :TestSuite<CR>
map <Leader>n :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>g :TestVisit<CR>
map <Leader>ss <ESC>:w<CR>:TestFile<CR>

" Git mappings
map <Leader>gb <ESC>:Git blame<CR>
map <Leader>cgb <ESC>:q<CR>:Git blame<CR>
map <Leader>cgbi <ESC>:q<CR>:Git blame<CR>i

" Show hidden files in CTRLP
let g:ctrlp_show_hidden = 1

" Remove trailing spaces with F6
:nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" 
" Don't overwrite register when pasting
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'
 
" Lists all buffers and waits for input
nnoremap <Leader>b :ls<CR>:b<Space>

" Prefer RipGrep over AG (faster)
command! -bang -nargs=* Rg
 \ call fzf#vim#grep(
 \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
 \   fzf#vim#with_preview(), <bang>0)

" (FZF) Open a new buffer at the bottom
let g:fzf_layout = { 'window': 'botright new' }

" make backspace work like most other programs
set backspace=2

" Highlights nginx.conf files
autocmd BufEnter nginx.conf* if &filetype == "" | setlocal ft=nginx | endif

" Add vim-fugitive to status line
set statusline+=%{fugitive#statusline()}

" Prevents Vim from scrolling when splitting the window horizontally.
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

" GitGutter workaround for updating buffer
autocmd BufWritePost * GitGutter

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'javascript': ['prettier'],
\}

" optional: Auto-correct on save.
let g:ale_fix_on_save = 1


if has('nvim')
let g:coq_settings = { 'auto_start': 'shut-up' }
lua << EOF
  local lsp = require "lspconfig"
  local coq = require "coq"
  lsp.solargraph.setup{}
  lsp.solargraph.setup(coq.lsp_ensure_capabilities{})
  lsp.tsserver.setup{}
  lsp.tsserver.setup(coq.lsp_ensure_capabilities{})
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
EOF

" Auto generate ctags on save
let g:auto_ctags = 1
let g:auto_ctags_warn_once = 1

" LSP
let g:lsp_diagnostics_enabled=0 " Let ALE handle diagnostics
let g:lsp_fold_enabled=0
let g:lsp_log_file=''
endif

let g:rainbow_active = 1

let test#ruby#use_spring_binstub = 1

let g:endwise_no_mappings = v:true
imap <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e>\<CR>\<Plug>DiscretionaryEnd" : "\<C-y>") : "\<CR>\<Plug>DiscretionaryEnd"

let g:gitgutter_preview_win_location = 'bo'
let g:gitgutter_preview_win_floating = 0

" .............................................................................
" lambdalisue/fern.vim
" .............................................................................

" Disable netrw.
"let g:loaded_netrw  = 1
"let g:loaded_netrwPlugin = 1
"let g:loaded_netrwSettings = 1
"let g:loaded_netrwFileHandlers = 1

"augroup my-fern-hijack
  "autocmd!
  "autocmd BufEnter * ++nested call s:hijack_directory()
"augroup END

"function! s:hijack_directory() abort
  "let path = expand('%:p')
  "if !isdirectory(path)
    "return
  "endif
  "bwipeout %
  "execute printf('Fern %s', fnameescape(path))
"endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

"noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
noremap <silent> <C-n> :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> <nowait> h <Plug>(fern-action-hidden:toggle)
  nmap <buffer> u <Plug>(fern-action-reload)
  nmap <buffer> x <Plug>(fern-action-mark:toggle)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" vim session autosave
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
