local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Map , as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Unmap some unwanted keys
keymap("", "q:", "<Nop>", opts) -- Disable : cmds history window
-- Disable standardwindow navigation (to get used with new keymaps)
keymap("", "<C-w>h", "<Nop>", opts)
keymap("", "<C-w>j", "<Nop>", opts)
keymap("", "<C-w>k", "<Nop>", opts)
keymap("", "<C-w>l", "<Nop>", opts)

-- Arrows and home keys
keymap("", "<Up>", "<NOP>", opts)
keymap("", "<Down>", "<NOP>", opts)
keymap("", "<Left>", "<NOP>", opts)
keymap("", "<Right>", "<NOP>", opts)
keymap("", "<PageUp>", "<NOP>", opts)
keymap("", "<PageDown>", "<NOP>", opts)
keymap("", "<Home>", "<NOP>", opts)
keymap("", "<End>", "<NOP>", opts)
keymap("", "<Del>", "<NOP>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------
-- Normal --
------------

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Fern navigation
keymap("n", "<C-n>", ":Fern . -drawer -width=35 -toggle<CR><C-w>=", opts)       -- Open fern
keymap("n", "<Leader>f", ":Fern . -drawer -reveal=% -width=35<CR><C-w>=", opts) -- Open fern and reveal current file
keymap("n", "<Leader>.", ":Fern %:h -drawer -width=35<CR><C-w>=", opts)         -- Open fern with file path as root

-- Trouble navigation
keymap("n", "<Leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- LSP toggle diagnostics virtual_text
vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.config({ virtual_text = true })
  end
end

keymap('n', '<Leader>d', ':call v:lua.toggle_diagnostics()<CR>', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", ":bdelete<CR>", opts)

-- Test mappings
keymap("n", "<Leader>t", ":TestFile<CR>", opts)
keymap("n", "<Leader>a", ":TestSuite<CR>", opts)
keymap("n", "<Leader>n", ":TestNearest<CR>", opts)
keymap("n", "<Leader>l", ":TestLast<CR>", opts)
keymap("n", "<Leader>g", ":TestVisit<CR>", opts)
keymap("n", "<Leader>ss", "<ESC>:w<CR>:TestFile<CR>", opts)   -- Save and run tests for current file
keymap("n", "<Leader>gt", ":A<CR> ", opts)                    -- Go to alternative file (test <> implementation)
keymap("n", "<leader>bp", "<ESC>Obinding.pry<ESC>,s,l", opts) -- Insert binding.pry and run nearest test

-- Misc
keymap("n", "<C-p>", ":Files<CR>", opts)                  -- Fuzzy find files
keymap("n", "<C-g>", ":Rg<Cr>", opts)                     -- Fuzzy find in tags
keymap("n", "<Leader>m", "@", opts)                       -- Quick access to macro
keymap("n", "<Leader>rua", "<ESC>:RuboCop -a<CR>", opts)  -- Run Rubocop autocorrect
keymap("n", "<Leader>ruaa", "<ESC>:RuboCop -A<CR>", opts) -- Run Rubocop autocorrect with -A
keymap("n", "<Leader>s", "<ESC>:w<CR>", opts)             -- Save
keymap("n", "<Leader>tt", "<ESC>:tabnew<CR>", opts)       -- New tab
keymap("n", "<leader>q", "<ESC>:q<CR>", opts)             -- Quit
keymap("n", "<C-f>", "<ESC>:Format<CR>", opts)            -- Format
keymap("n", "<CR>", ":nohlsearch<CR>", opts)              -- Clear search highlight
keymap("n", "<Leader>gb", "<ESC>:Git blame<CR>", opts)    -- Git blame
-- Clear trailing spaces with F6
keymap("n", "<F6>", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", opts)

------------
-- Visual --
------------

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "p", "P", opts) -- paste in visual mode without overwriting

------------------
-- Visual Block --
------------------

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--------------
-- Terminal --
--------------

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
