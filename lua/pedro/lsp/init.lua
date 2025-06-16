local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- Apply workaround for mason-lspconfig compatibility issue
require "pedro.mason_workaround".setup()

-- First set up Mason to install LSP servers
require "pedro.lsp.mason"
-- Then set up handlers to configure the servers
require "pedro.lsp.handlers".setup()
-- Finally set up null-ls
require "pedro.lsp.null-ls"
