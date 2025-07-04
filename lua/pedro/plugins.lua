local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  -- SYNTAX HIGHLIGHTING
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'HiPhish/rainbow-delimiters.nvim'
  use "slim-template/vim-slim"
  use "lukas-reineke/indent-blankline.nvim" -- Indentation guides

  -- EDITING & MOVEMENTS
  use "mattesgroeger/vim-bookmarks" -- Vim Bookmarks upgrade
  use "tpope/vim-repeat"            -- Remap . to repeat plugin remaps
  use "unblevable/quick-scope"      -- Highlights letters for <f>
  use "karb94/neoscroll.nvim"       -- Smooth scrolling

  -- SEARCH
  use "google/vim-searchindex" -- Adds info to search results (char /)
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }

  -- CODING
  use "AndrewRadev/splitjoin.vim" -- Split/Join lines
  use "vim-test/vim-test"          -- A Vim wrapper for running tests on different granularities.
  use "scrooloose/nerdcommenter"  -- NERD commenter
  use "tpope/vim-speeddating"     -- Adds date support to C-A and C-X
  use "tpope/vim-surround"        -- Quotes substitution
  use "tpope/vim-unimpaired"      -- Pairs of handy bracket mappings

  -- CMP
  use "hrsh7th/nvim-cmp"                                     -- The completion plugin
  use { "L3MON4D3/LuaSnip" }                                 -- Snippet engine
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }           -- Buffer completions
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }             -- Path completions
  use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }          -- Cmdline completions
  use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }     -- Snippet completions
  use { "rafamadriz/friendly-snippets", after = "nvim-cmp" } -- A bunch of snippets to use
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }         -- LSP source for CMP
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }         -- Lua API source for CMP
  use { "zbirenbaum/copilot.lua", after = "nvim-cmp",        -- Pure Lua replacement for Copilot
    cmd = "Copilot", event = "InsertEnter", config = function() require("copilot").setup({}) end }
  use { "zbirenbaum/copilot-cmp",                            -- Copilot source for CMP
    after = { "copilot.lua" }, config = function() require("copilot_cmp").setup() end }

  -- LSP
  use "neovim/nvim-lspconfig"             -- Enable LSP
  use "williamboman/mason.nvim"           -- Simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- Bridges mason.nvim with the lspconfig plugin
  use 'nvimtools/none-ls.nvim'            -- LSP diagnostics and code actions (old null_ls)

  -- LANGUAGE SPECIFIC PLUGINS
  use({ "elixir-tools/elixir-tools.nvim", tag = "stable", requires = { "nvim-lua/plenary.nvim" }})

  -- AI

  -- NAVIGATION & FILE CONFIGURATION
  use { "nvim-tree/nvim-tree.lua",   -- Tree viewer
    requires = "antoinemadec/FixCursorHold.nvim" }
  use "tpope/vim-projectionist"      -- Configurable projections (like go to test file and back)
  use "nvim-lualine/lualine.nvim"    -- Neovim statusline plugin written in lua

  -- GIT
  use "lewis6991/gitsigns.nvim" -- Git diff info in the sign column
  use "tpope/vim-fugitive"      -- Git wrapper

  -- LINTERS/FORMATTERS
  use "ngmy/vim-rubocop"           -- RuboCop
  --use "prettier/vim-prettier"      -- Prettier
  use 'mhartington/formatter.nvim' -- Formatter

  -- THEMES
  use "folke/tokyonight.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- SYSTEM
  --use "dhruvasagar/vim-prosession"
  --use "tpope/vim-obsession"
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use { "folke/trouble.nvim",  -- A pretty list of diagnostics
    requires = "nvim-tree/nvim-web-devicons" }
  use "wincent/terminus"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
