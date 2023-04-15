let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:edge_style = 'default'
let g:edge_better_performance = 1
filetype indent on                            " Load indent file for the current filetype
filetype plugin on                            " Enable filetype-specific plugins
highlight LineNr ctermfg=darkgrey
set rtp+=/opt/homebrew/opt/fzf

" Red column at position 80
highlight ColorColumn ctermbg=88 guibg=#d70000

let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_layout = { 'down': '20%' }

" Show hidden files in CTRLP
let g:ctrlp_show_hidden = 1

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_a = airline#section#create(['mode']) " default: mode, crypt, paste, spell, iminsert
let g:airline_section_b = airline#section#create(['hunks','']) " default hunks, branch
let g:airline_section_x = airline#section#create(['tagbar']) " default tagbar, filetype, virtualenv
let g:airline_section_y = airline#section#create([]) " default fileencoding, fileformat, 'bom', 'eol'

" GitGutter workaround for updating buffer
autocmd BufWritePost * GitGutter

if has('nvim')
  " Auto generate ctags on save
  let g:auto_ctags = 1
  let g:auto_ctags_warn_once = 1
endif

let test#ruby#use_spring_binstub = 1
let test#ruby#rspec#executable = 'rspec'

let g:endwise_no_mappings = v:true

let g:gitgutter_preview_win_location = 'bo'
let g:gitgutter_preview_win_floating = 0

let g:fern#disable_default_mappings = 1

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
