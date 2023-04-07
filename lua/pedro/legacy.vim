set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" COQ sets those keymaps, but they conflict with better window navigation
let g:coq_settings = { "keymap.bigger_preview": "" }
let g:coq_settings = { "keymap.jump_to_mark": "" }
