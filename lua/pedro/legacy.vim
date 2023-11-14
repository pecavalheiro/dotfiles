set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" https://github.com/vim/vim/issues/4830
" Proper file detection
" JavaScript with React
au BufNewFile,BufRead *.jsx setf javascriptreact
" TypeScript with React
au BufNewFile,BufRead *.tsx setf typescriptreact

" force craco to run jest if localyze project
autocmd BufNewFile,BufRead ~/projects/localyze/*backend/client/* let test#javascript#jest#executable = 'yarn test --watchAll=false'

" junegunn/fzf.vim
set rtp+=/opt/homebrew/opt/fzf
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_layout = { 'down': '30%' }
