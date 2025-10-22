-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Setup lazy.nvim
lazy.setup({
  -- SYNTAX HIGHLIGHTING
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
  },
  { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
  { "slim-template/vim-slim", ft = "slim" },
  { "lukas-reineke/indent-blankline.nvim", event = "BufReadPost" }, -- Indentation guides

  -- EDITING & MOVEMENTS
  { "mattesgroeger/vim-bookmarks", keys = { "mm", "mi", "mn", "mp", "mc", "mx", "mkk", "mjj" } }, -- Vim Bookmarks upgrade
  { "tpope/vim-repeat", event = "VeryLazy" }, -- Remap . to repeat plugin remaps
  { "unblevable/quick-scope", event = { "BufReadPost", "BufNewFile" } }, -- Highlights letters for <f>
  { "karb94/neoscroll.nvim", event = "VeryLazy" }, -- Smooth scrolling

  -- SEARCH
  { "google/vim-searchindex", event = "VeryLazy" }, -- Adds info to search results (char /)
  {
    "junegunn/fzf.vim",
    dependencies = {
      { "junegunn/fzf", build = ":call fzf#install()" },
    },
    cmd = { "Files", "Buffers", "Rg", "Lines", "BLines", "Tags", "BTags", "Marks", "Windows", "History" },
  },

  -- CODING
  { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" } }, -- Split/Join lines
  { "vim-test/vim-test", event = "VeryLazy" }, -- A Vim wrapper for running tests on different granularities.
  { "scrooloose/nerdcommenter", keys = { "<leader>c", { "<leader>c", mode = "v" } } }, -- NERD commenter
  { "tpope/vim-speeddating", keys = { "<C-a>", "<C-x>" } }, -- Adds date support to C-A and C-X
  { "tpope/vim-surround", keys = { "cs", "ds", "ys" } }, -- Quotes substitution
  { "tpope/vim-unimpaired", event = "VeryLazy" }, -- Pairs of handy bracket mappings

  -- CMP
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- Buffer completions
      "hrsh7th/cmp-path", -- Path completions
      "hrsh7th/cmp-cmdline", -- Cmdline completions
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
      "hrsh7th/cmp-nvim-lsp", -- LSP source for CMP
      "hrsh7th/cmp-nvim-lua", -- Lua API source for CMP
      "L3MON4D3/LuaSnip", -- Snippet engine
      "rafamadriz/friendly-snippets", -- A bunch of snippets to use
    },
  },

 --  CMP dependency
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.4", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    --    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua", -- Pure Lua replacement for Copilot
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Avante AI
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      cursor_applying_provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          api_key_name = "ANTHROPIC_API_KEY",
          extra_request_body = {
            max_tokens = 4096,
          },
          timeout = 30000,
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        enable_cursor_planning_mode = true,
      },
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      diff = {
        autojump = true,
        list_opener = "copen",
      },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- LSP
  { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } }, -- Enable LSP
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = { "BufReadPre", "BufNewFile" },
  }, -- Simple to use language server installer
  { "williamboman/mason-lspconfig.nvim", event = { "BufReadPre", "BufNewFile" } }, -- Bridges mason.nvim with the lspconfig plugin
  { "nvimtools/none-ls.nvim", event = { "BufReadPre", "BufNewFile" } }, -- LSP diagnostics and code actions (old null_ls)

  -- LANGUAGE SPECIFIC PLUGINS
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    ft = { "elixir", "eex", "heex" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- NAVIGATION & FILE CONFIGURATION
  {
    "nvim-tree/nvim-tree.lua", -- Tree viewer
    event = "VeryLazy",
    dependencies = { "antoinemadec/FixCursorHold.nvim" },
  },
  { "tpope/vim-projectionist", event = { "BufReadPost", "BufNewFile" } }, -- Configurable projections (like go to test file and back)
  { "nvim-lualine/lualine.nvim", event = "VeryLazy" }, -- Neovim statusline plugin written in lua

  -- GIT
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" } }, -- Git diff info in the sign column
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
  }, -- Git wrapper

  -- LINTERS/FORMATTERS
  { "ngmy/vim-rubocop", ft = "ruby" }, -- RuboCop
  { "mhartington/formatter.nvim", cmd = { "Format", "FormatWrite" } }, -- Formatter

  -- THEMES
  { "folke/tokyonight.nvim", priority = 1000 },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- SYSTEM
  { "nvim-lua/plenary.nvim", lazy = true }, -- Useful lua functions used ny lots of plugins
  { "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
  {
    "folke/trouble.nvim", -- A pretty list of diagnostics
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "wincent/terminus", event = "VeryLazy" },
}, {
  -- Lazy.nvim configuration options
  install = {
    -- install missing plugins on startup
    missing = true,
  },
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
