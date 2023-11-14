-- required for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "pedro/keymaps"
require "pedro/plugins"
require "pedro/colorscheme"
require "pedro/cmp"
require "pedro/lsp"
require "pedro/lualine"
require "pedro/treesitter"
require "pedro/nvim-tree"
require "pedro/copilot"
require "pedro/gitsigns"
require "pedro/trouble"
require "pedro/formatter"
require "pedro/indent_blankline"
require "pedro/options"
vim.cmd('source ~/.config/nvim/lua/pedro/legacy.vim')
