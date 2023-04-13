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

-- Have packer use a popup window
--packer.init {
  --display = {
    --open_fn = function()
      --return require("packer.util").float { border = "rounded" }
    --end,
  --},
--}

return packer.startup(function(use)

  -- PROCESSING
  use "dense-analysis/ale"              -- Asynchronous Lint Engine

  -- SYNTAX HIGHLIGHING
  --use "jparise/vim-graphql"             -- GraphQL file detection, syntax highlighting, and indentation.
  use "aliou/sql-heredoc.vim"           -- Syntax highlighting for SQL heredocs
  use "amadeus/vim-mjml"                -- MJML syntax (email html)
  use "chr4/nginx.vim"                  -- Nginx syntax highligh
  use "ekalinin/Dockerfile.vim"         -- Dockerfile syntax
  use "elixir-lang/vim-elixir"          -- Elixir support for vim
  use "keith/rspec.vim"                 -- Rspec better highlight
  use "kylef/apiblueprint.vim"          -- API Blueprint highlight
  use "luochen1990/rainbow"             -- Diff level of parentheses in diff color
  use "mxw/vim-jsx"                     -- Syntax highlighting and indenting for JSX
  use "othree/html5.vim"                -- HTML5 syntax highlighting
  use "pangloss/vim-javascript"         -- syntax highlighting and improved indentation
  use "slim-template/vim-slim"          -- Slim syntax highlighting for vim.
  use "vim-scripts/matchit.zip"         -- Vim Matchit
  use "vim-scripts/ruby-matchit"        -- Ruby Matchit
  use { "prettier/vim-prettier", run = "cd app && yarn install" }

  -- NAVIGATION & FILE CONFIGURATION
  use { "lambdalisue/fern.vim",         -- Tree viewer
        requires = "antoinemadec/FixCursorHold.nvim" }
  use "ludovicchabant/vim-gutentags"    -- Auto indexes ctags in the background
  use "tpope/vim-projectionist"         -- Configurable projections (like go to test file and back)
  use "vim-airline/vim-airline"         -- Lean & mean status/tabline
  use "vim-airline/vim-airline-themes"  -- Themes for Vim-Airline

  -- EDITING & MOVEMENTS
  use "mattesgroeger/vim-bookmarks"     -- Vim Bookmarks upgrade
  use "tpope/vim-repeat"                -- Remap . to repeat plugin remaps
  use "unblevable/quick-scope"          -- Highlights letters for <f>

  -- SEARCH
  use "google/vim-searchindex"          -- Adds info to search results (char /)
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install' ](0) end }
  use "junegunn/fzf.vim"                -- Fuzzy finder

  -- CODING
  use "AndrewRadev/splitjoin.vim"       -- Split/Join lines
  use "janko-m/vim-test"                -- A Vim wrapper for running tests on different granularities.
  use "scrooloose/nerdcommenter"        -- NERD commenter
  use "tpope/vim-speeddating"           -- Adds date support to C-A and C-X
  use "tpope/vim-surround"              -- Quotes substitution
  use "tpope/vim-unimpaired"            -- Pairs of handy bracket mappings

  -- CMP
  use "hrsh7th/nvim-cmp"                -- The completion plugin
  use "hrsh7th/cmp-buffer"              -- Buffer completions
  use "hrsh7th/cmp-path"                -- Path completions
  use "hrsh7th/cmp-cmdline"             -- Cmdline completions
  use "saadparwaiz1/cmp_luasnip"        -- Snippet completions
  use "L3MON4D3/LuaSnip"                -- Snippet engine
  use "rafamadriz/friendly-snippets"    -- A bunch of snippets to use

  -- GIT
  use "airblade/vim-gitgutter"          -- Shows a git diff
  use "mhinz/vim-signify"               -- Git diff in the gutter
  use "tpope/vim-fugitive"              -- Git wrapper

  -- RUBY/RAILS
  use "ngmy/vim-rubocop"                -- RuboCop

  -- THEMES
  --use "sainnhe/edge"
  use "folke/tokyonight.nvim"
  --   use "ayu-theme/ayu-vim"
  --   use "drewtempelmeyer/palenight.vim"
  --   use "jpo/vim-railscasts-theme"   -- Railcasts Theme

  -- Go
  use { "fatih/vim-go", run = ":GoUpdateBinaries" }

  -- SYSTEM
  use "dhruvasagar/vim-prosession"
  use "neovim/nvim-lspconfig"   -- Collection of common configurations for the Nvim LSP client
  use "nvim-lua/plenary.nvim"   -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"     -- An implementation of the Popup API from vim in Neovim
  use "tpope/vim-obsession"
  use "wbthomason/packer.nvim"  -- Have packer manage itself

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

