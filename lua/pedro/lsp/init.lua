local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "pedro.lsp.mason"
require("pedro.lsp.handlers").setup()
require "pedro.lsp.null-ls"
