local options = {
  autoindent = true,                                -- Copy the indent of the current line when starting a new line
  autoread = true,                                  -- automatically reload a file if it was changed from the outside
  backspace = "indent,eol,start",                   -- allow backspacing over everything in insert mode
  backup = false,                                   -- Creates a backup file
  clipboard = "unnamedplus",                        -- Allows neovim to access the system clipboard
  cmdheight = 1,                                    -- More space in the neovim command line for displaying messages
  colorcolumn = { 80, 100 },                        -- Line to the 80th character
  conceallevel = 0,                                 -- So that `` is visible in markdown files
  cursorline = true,                                -- highlight the current line
  cursorcolumn = true,                              -- highlight the current column
  expandtab = true,                                 -- convert tabs to spaces
  fileencoding = "utf-8",                           -- The encoding written to a file
  guifont = "monospace:h17",                        -- the font used in graphical neovim applications
  history = 100,                                    -- Maximum number of previous ":" commands
  hlsearch = true,                                  -- Highlight all matches on previous search pattern
  ignorecase = true,                                -- Ignore case in search patterns
  incsearch = true,                                 -- show search matches while typing
  list = true,                                      -- Show some invisible characters (tabs...)
  listchars = "tab:»·,trail:·,nbsp:·,extends:#",    -- Unicode characters used for rendering whitespace
  mouse = "",
  number = true,                                    -- set numbered lines
  numberwidth = 3,                                  -- set number column width to 3 {default 4}
  pastetoggle = "<F2>",                             -- Enables paste mode
  pumheight = 10,                                   -- Pop up menu height
  relativenumber = false,                           -- set relative numbered lines
  ruler = true,
  scrolloff = 8,                                    -- Minimal number of screen lines to keep above and below the cursor.
  shiftwidth = 2,                                   -- the number of spaces inserted for each indentation
  showbreak = "↪",                                  -- display symbol at the beginning of wrapped line
  showmode = true,                                  -- Shows current mode (insert, visual, replace)
  showtabline = 2,                                  -- Always show tabs
  sidescrolloff = 8,                                -- same for horizontal
  signcolumn = "yes",                               -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                                 -- Smart case
  smartindent = true,                               -- Make indenting smarter again
  softtabstop = 2,                                  -- insert 2 spaces for a tab during editing operations
  splitbelow = true,                                -- force all horizontal splits to go below current window
  splitright = true,                                -- force all vertical splits to go to the right of current window
  swapfile = false,                                 -- creates a swapfile
  syntax = "on",                                    -- syntax highlighting
  tabstop = 2,                                      -- insert 2 spaces for a tab
  tags = "tags",                                    -- tags file
  termguicolors = true,                             -- set term gui colors (most terminals support this)
  timeoutlen = 400,                                 -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true,                                     -- set the title of window
  undofile = true,                                  -- enable persistent undo
  undolevels = 200,                                 -- Maximum number of changes that can be undone.
  updatetime = 300,                                 -- faster completion (4000ms default)
  visualbell = true,                                -- Use visual bell instead of beeping.
  wrap = true,                                      -- display lines as one long line
  writebackup = false,                              -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.diffopt:append "vertical"                       -- GitHub style diff
vim.cmd [[highlight ColorColumn ctermbg=88 guibg=#d70000]] -- Red color column (80, 100)

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- examples on how to run vim commands
--vim.cmd "set whichwrap+=<,>,[,],h,l"
--vim.cmd [[set iskeyword+=-]]
