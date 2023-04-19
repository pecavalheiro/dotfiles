set rtp+=/opt/homebrew/opt/fzf

let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_layout = { 'down': '20%' }

" Airline bar settings
let g:airline_powerline_fonts = 1 " Fancy fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_a = airline#section#create(['mode']) " default: mode, crypt, paste, spell, iminsert
let g:airline_section_b = airline#section#create(['hunks','']) " default hunks, branch
let g:airline_section_x = airline#section#create(['tagbar']) " default tagbar, filetype, virtualenv
let g:airline_section_y = airline#section#create([]) " default fileencoding, fileformat, 'bom', 'eol'

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
